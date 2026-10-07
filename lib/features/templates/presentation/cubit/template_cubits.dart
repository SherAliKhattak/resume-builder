import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printing/printing.dart';

import '../../../../core/errors/app_error.dart';
import '../../../../core/errors/error_logger.dart';

import '../../../../app/di.dart';
import '../../../export/domain/models/resume_settings.dart';
import '../../../profile/domain/models/resume_data.dart';
import '../../../profile/domain/repositories/resume_repository.dart';
import '../../../../seed/sample_resume.dart';
import '../../domain/resume_template.dart';
import '../../domain/template_registry.dart';
import '../../pdf/pdf_helpers.dart';
import '../../pdf/pdf_raster_service.dart';
import '../../pdf/pdf_safe.dart';

class TemplateGalleryState {
  const TemplateGalleryState({
    this.data = const ResumeData(),
    this.selectedId = 'classic',
    this.thumbnails = const {},
    this.message,
  });

  final ResumeData data;
  final String selectedId;
  final Map<String, Uint8List> thumbnails;
  final String? message;

  ResumeData get previewData => SampleResume.forPreview(data);

  TemplateGalleryState copyWith({
    ResumeData? data,
    String? selectedId,
    Map<String, Uint8List>? thumbnails,
    String? message,
    bool clearMessage = false,
  }) {
    return TemplateGalleryState(
      data: data ?? this.data,
      selectedId: selectedId ?? this.selectedId,
      thumbnails: thumbnails ?? this.thumbnails,
      message: clearMessage ? null : (message ?? this.message),
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
    _sub = listenLogged(
      _repository.watchResume(),
      (data) {
        emit(state.copyWith(data: data, selectedId: data.settings.templateId));
        _loadThumbnails();
      },
      name: 'TemplateGalleryCubit.watch',
      isClosed: () => isClosed,
    );
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
          state.copyWith(thumbnails: {...state.thumbnails, template.id: png}),
        );
      } catch (error, stack) {
        logAppError('TemplateGalleryCubit.thumbnail', error, stack);
      }
    }
  }

  Future<void> select(String id) async {
    emit(state.copyWith(selectedId: id, clearMessage: true));
    try {
      await _repository.saveSettings(
        state.data.settings.copyWith(templateId: id),
      );
    } catch (error, stack) {
      logAppError('TemplateGalleryCubit.select', error, stack);
      if (!isClosed) {
        emit(
          state.copyWith(
            message: userFacingMessage(
              error,
              fallback: 'Could not save that template. Try again.',
            ),
          ),
        );
      }
    }
  }

  Future<Uint8List> pdfBytes(ResumeTemplate template) async {
    final doc = await fitToOnePage(
      style: TemplateStyle.fromSettings(state.data.settings),
      build: (style) => template.build(pdfSafeResume(state.previewData), style),
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
    this.message,
  });

  final ResumeData data;
  final bool busy;
  final bool ready;
  final String? message;

  ExportState copyWith({
    ResumeData? data,
    bool? busy,
    bool? ready,
    String? message,
    bool clearMessage = false,
  }) {
    return ExportState(
      data: data ?? this.data,
      busy: busy ?? this.busy,
      ready: ready ?? this.ready,
      message: clearMessage ? null : (message ?? this.message),
    );
  }
}

class ExportCubit extends Cubit<ExportState> {
  ExportCubit(this._repository, this.registry) : super(const ExportState());

  final ResumeRepository _repository;
  final TemplateRegistry registry;
  StreamSubscription<ResumeData>? _sub;

  void start() {
    _sub = listenLogged(
      _repository.watchResume(),
      (data) => emit(state.copyWith(data: data, ready: true)),
      name: 'ExportCubit.watch',
      isClosed: () => isClosed,
    );
  }

  Future<Uint8List> buildPdf() async {
    final template = registry.byId(state.data.settings.templateId);
    final doc = await fitToOnePage(
      style: TemplateStyle.fromSettings(state.data.settings),
      build: (style) => template.build(
        pdfSafeResume(SampleResume.forPreview(state.data)),
        style,
      ),
    );
    return doc.save();
  }

  Future<void> share() async {
    emit(state.copyWith(busy: true, clearMessage: true));
    try {
      final bytes = await buildPdf();
      final name = state.data.personal.fullName.trim().isEmpty
          ? 'resume'
          : state.data.personal.fullName.replaceAll(' ', '-');
      await Printing.sharePdf(bytes: bytes, filename: '$name.pdf');
      if (!isClosed) emit(state.copyWith(busy: false));
    } catch (error, stack) {
      logAppError('ExportCubit.share', error, stack);
      if (!isClosed) {
        emit(
          state.copyWith(
            busy: false,
            message: userFacingMessage(
              error,
              fallback: 'Could not share the PDF. Try again.',
            ),
          ),
        );
      }
    }
  }

  Future<void> updateSettings(ResumeSettings settings) async {
    try {
      await _repository.saveSettings(settings);
    } catch (error, stack) {
      logAppError('ExportCubit.settings', error, stack);
      if (!isClosed) {
        emit(
          state.copyWith(
            message: userFacingMessage(
              error,
              fallback: 'Could not save those preview settings.',
            ),
          ),
        );
      }
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
