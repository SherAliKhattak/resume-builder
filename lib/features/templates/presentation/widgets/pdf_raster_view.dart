import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../../../app/di.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/errors/error_logger.dart';
import '../../pdf/pdf_raster_service.dart';

class PdfRasterView extends StatefulWidget {
  const PdfRasterView({
    super.key,
    required this.buildPdf,
    this.repaintToken,
    this.fallback,
  });

  final Future<Uint8List> Function() buildPdf;
  final Object? repaintToken;
  final Widget? fallback;

  @override
  State<PdfRasterView> createState() => _PdfRasterViewState();
}

class _PdfRasterViewState extends State<PdfRasterView> {
  final _pages = <PdfRaster>[];
  var _loading = true;
  Object? _error;
  var _loadId = 0;
  Timer? _reload;

  PdfRasterService get _raster => getIt<PdfRasterService>();

  @override
  void initState() {
    super.initState();
    _raster.beginPreview();
    _load();
  }

  @override
  void didUpdateWidget(covariant PdfRasterView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.repaintToken != widget.repaintToken) {
      _reload?.cancel();
      _reload = Timer(const Duration(milliseconds: 280), _load);
    }
  }

  @override
  void dispose() {
    _reload?.cancel();
    _raster.endPreview();
    super.dispose();
  }

  Future<void> _load() async {
    final id = ++_loadId;
    if (!mounted) return;
    setState(() {
      _loading = true;
      _error = null;
      _pages.clear();
    });
    try {
      final pdf = await widget.buildPdf().timeout(const Duration(seconds: 12));
      if (!mounted || id != _loadId) return;
      await for (final page in _raster.rasterPages(pdf)) {
        if (!mounted || id != _loadId) return;
        setState(() {
          _pages.add(page);
          _loading = false;
          _error = null;
        });
      }
      if (!mounted || id != _loadId) return;
      setState(() {
        _loading = false;
        if (_pages.isEmpty) {
          _error = 'empty';
        }
      });
    } catch (error, stack) {
      logAppError('PdfRasterView.load', error, stack);
      if (!mounted || id != _loadId) return;
      setState(() {
        _error = error;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_pages.isEmpty) {
      final fallback = widget.fallback;
      if (fallback != null) {
        return Stack(
          children: [
            fallback,
            if (_loading)
              const Align(
                alignment: Alignment.topCenter,
                child: LinearProgressIndicator(),
              ),
            if (_error != null && !_loading)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: TextButton(
                    onPressed: _load,
                    child: const Text('Try template preview again'),
                  ),
                ),
              ),
          ],
        );
      }
      if (_loading) {
        return const Center(child: CircularProgressIndicator());
      }
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Could not preview this resume.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: _load,
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
      );
    }

    final scheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        ListView.separated(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenPadding,
            AppSpacing.sm,
            AppSpacing.screenPadding,
            AppSpacing.lg,
          ),
          itemCount: _pages.length,
          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
          itemBuilder: (context, index) {
            final page = _pages[index];
            return DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(AppRadii.md),
                border: Border.all(
                  color: scheme.outlineVariant.withValues(alpha: 0.5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: scheme.shadow.withValues(alpha: 0.08),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadii.md),
                child: _PdfPageImage(page: page),
              ),
            );
          },
        ),
        if (_loading)
          const Align(
            alignment: Alignment.topCenter,
            child: LinearProgressIndicator(),
          ),
      ],
    );
  }
}

class _PdfPageImage extends StatefulWidget {
  const _PdfPageImage({required this.page});

  final PdfRaster page;

  @override
  State<_PdfPageImage> createState() => _PdfPageImageState();
}

class _PdfPageImageState extends State<_PdfPageImage> {
  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    _decode();
  }

  @override
  void didUpdateWidget(covariant _PdfPageImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.page, widget.page)) {
      _image?.dispose();
      _image = null;
      _decode();
    }
  }

  Future<void> _decode() async {
    try {
      final image = await widget.page.toImage();
      if (!mounted) {
        image.dispose();
        return;
      }
      setState(() => _image = image);
    } catch (error, stack) {
      logAppError('PdfRasterView.decode', error, stack);
    }
  }

  @override
  void dispose() {
    _image?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image = _image;
    final ratio = widget.page.width / widget.page.height;
    if (image == null) {
      return AspectRatio(
        aspectRatio: ratio,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    return AspectRatio(
      aspectRatio: ratio,
      child: RawImage(image: image, fit: BoxFit.contain),
    );
  }
}
