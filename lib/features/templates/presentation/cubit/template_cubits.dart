import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printing/printing.dart';

import '../../../../app/di.dart';
import '../../../export/domain/models/resume_settings.dart';
import '../../../profile/domain/models/resume_data.dart';
import '../../../profile/domain/repositories/resume_repository.dart';
import '../../../../seed/sample_resume.dart';
import '../../domain/resume_template.dart';
import '../../domain/template_registry.dart';
import '../../pdf/pdf_raster_service.dart';
import '../../pdf/pdf_safe.dart';

class TemplateGalleryState {
  const TemplateGalleryState({
    this.data = const ResumeData(),
    this.selectedId = 'classic',
    this.thumbnails = const {},
  });

  final ResumeData data;
  final String selectedId;
  final Map<String, Uint8List> thumbnails;

  ResumeData get previewData => SampleResume.forPreview(data);

  TemplateGalleryState copyWith({
    ResumeData? data,
    String? selectedId,
    Map<String, Uint8List>? thumbnails,
  }) {
    return TemplateGalleryState(
      data: data ?? this.data,
      selectedId: selectedId ?? this.selectedId,
      thumbnails: thumbnails ?? this.thumbnails,
    );
  }
}

class TemplateGalleryCubit extends Cubit<TemplateGalleryState> {
  TemplateGalleryCubit(this._repository, this.registry)
    : super(const TemplateGalleryState());

  final ResumeRepository _repository;
  final TemplateRegistry registry;
  StreamSubscription<ResumeData>? _sub;
  var _thumbGeneration = 0;

  void start() {
    _sub = _repository.watchResume().listen((data) {
      if (isClosed) return;
      emit(
        state.copyWith(
          data: data,
          selectedId: data.settings.templateId,
        ),
      );
      _loadThumbnails();
    });
  }

  Future<void> _loadThumbnails() async {
    final generation = ++_thumbGeneration;
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (isClosed || generation != _thumbGeneration) return;
    final raster = getIt<PdfRasterService>();
    for (final template in registry.all) {
      if (isClosed || generation != _thumbGeneration) return;
      await raster.waitWhilePreviewing();
      if (isClosed || generation != _thumbGeneration) return;
      try {
        final pdf = await pdfBytes(template);
        if (isClosed || generation != _thumbGeneration) return;
        final png = await raster.rasterFirstPage(pdf);
        if (isClosed || generation != _thumbGeneration) return;
        emit(
          state.copyWith(
            thumbnails: {...state.thumbnails, template.id: png},
          ),
        );
      } catch (_) {}
    }
  }

  Future<void> select(String id) async {
    emit(state.copyWith(selectedId: id));
    await _repository.saveSettings(state.data.settings.copyWith(templateId: id));
  }

  Future<Uint8List> pdfBytes(ResumeTemplate template) async {
    final doc = await template.build(
      pdfSafeResume(state.previewData),
      TemplateStyle.fromSettings(state.data.settings),
    );
    return doc.save();
  }

  @override
  Future<void> close() {
    _thumbGeneration++;
    _sub?.cancel();
    return super.close();
  }
}

class ExportState {
  const ExportState({
    this.data = const ResumeData(),
    this.busy = false,
    this.ready = false,
  });

  final ResumeData data;
  final bool busy;
  final bool ready;

  ExportState copyWith({ResumeData? data, bool? busy, bool? ready}) {
    return ExportState(
      data: data ?? this.data,
      busy: busy ?? this.busy,
      ready: ready ?? this.ready,
    );
  }
}

class ExportCubit extends Cubit<ExportState> {
  ExportCubit(this._repository, this.registry) : super(const ExportState());

  final ResumeRepository _repository;
  final TemplateRegistry registry;
  StreamSubscription<ResumeData>? _sub;

  void start() {
    _sub = _repository.watchResume().listen((data) {
      if (!isClosed) emit(state.copyWith(data: data, ready: true));
    });
  }

  Future<Uint8List> buildPdf() async {
    final template = registry.byId(state.data.settings.templateId);
    final doc = await template.build(
      pdfSafeResume(SampleResume.forPreview(state.data)),
      TemplateStyle.fromSettings(state.data.settings),
    );
    return doc.save();
  }

  Future<void> share() async {
    emit(state.copyWith(busy: true));
    try {
      final bytes = await buildPdf();
      final name = state.data.personal.fullName.trim().isEmpty
          ? 'resume'
          : state.data.personal.fullName.replaceAll(' ', '-');
      await Printing.sharePdf(bytes: bytes, filename: '$name.pdf');
    } finally {
      if (!isClosed) emit(state.copyWith(busy: false));
    }
  }

  Future<void> updateSettings(ResumeSettings settings) {
    return _repository.saveSettings(settings);
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
