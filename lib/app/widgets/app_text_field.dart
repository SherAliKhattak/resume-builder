import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.helperText,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
    this.minLines,
    this.errorText,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.sentences,
    this.inputFormatters,
    this.onSubmitted,
    this.focusNode,
    this.obscureText = false,
    this.prefixIcon,
    this.enabled = true,
  });

  final String label;
  final String? hint;
  final String? helperText;
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final int maxLines;
  final int? minLines;
  final String? errorText;
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final bool obscureText;
  final IconData? prefixIcon;
  final bool enabled;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  TextEditingController? _owned;
  FocusNode? _ownedFocus;

  TextEditingController get _controller => widget.controller ?? _owned!;
  FocusNode get _focus => widget.focusNode ?? _ownedFocus!;

  bool get _multiline => widget.maxLines > 1;

  TextEditingController? _listeningController;
  FocusNode? _listeningFocus;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _owned = TextEditingController(text: widget.initialValue);
    }
    if (widget.focusNode == null) {
      _ownedFocus = FocusNode(debugLabel: widget.label);
    }
    _attachListeners();
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && oldWidget.controller != null) {
      _owned = TextEditingController(
        text: widget.initialValue ?? oldWidget.controller?.text,
      );
    }
    if (widget.controller != null && oldWidget.controller == null) {
      _owned?.dispose();
      _owned = null;
    }
    if (widget.focusNode == null && oldWidget.focusNode != null) {
      _ownedFocus = FocusNode(debugLabel: widget.label);
    }
    if (widget.focusNode != null && oldWidget.focusNode == null) {
      _ownedFocus?.dispose();
      _ownedFocus = null;
    }
    _attachListeners();
  }

  void _attachListeners() {
    if (_listeningController != _controller) {
      _listeningController?.removeListener(_onChanged);
      _listeningController = _controller;
      _listeningController!.addListener(_onChanged);
    }
    if (_listeningFocus != _focus) {
      _listeningFocus?.removeListener(_onChanged);
      _listeningFocus = _focus;
      _listeningFocus!.addListener(_onChanged);
    }
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _listeningController?.removeListener(_onChanged);
    _listeningFocus?.removeListener(_onChanged);
    _owned?.dispose();
    _ownedFocus?.dispose();
    super.dispose();
  }

  IconData? get _icon {
    if (widget.prefixIcon != null) return widget.prefixIcon;
    if (_multiline) return null;
    switch (widget.keyboardType) {
      case TextInputType.emailAddress:
        return Icons.mail_outline_rounded;
      case TextInputType.phone:
        return Icons.phone_outlined;
      case TextInputType.url:
        return Icons.link_rounded;
      case TextInputType.name:
        return Icons.person_outline_rounded;
      case TextInputType.streetAddress:
        return Icons.place_outlined;
      default:
        return null;
    }
  }

  bool get _plainInput {
    final type = widget.keyboardType;
    return type == TextInputType.emailAddress ||
        type == TextInputType.url ||
        type == TextInputType.phone ||
        type == TextInputType.visiblePassword;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final focused = _focus.hasFocus;
    final hasError = widget.errorText != null;
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = hasError
        ? scheme.error
        : focused
        ? AppColors.seed
        : (isDark
              ? scheme.outlineVariant.withValues(alpha: 0.5)
              : AppColors.fieldBorder);
    final fill = isDark ? scheme.surface : Colors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: hasError ? scheme.error : scheme.onSurface,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.1,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedContainer(
          duration: AppDurations.fast,
          curve: AppCurves.standard,
          decoration: BoxDecoration(
            color: fill,
            borderRadius: BorderRadius.circular(AppRadii.lg),
            border: Border.all(
              color: borderColor,
              width: focused || hasError ? 1.4 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: focused
                    ? AppColors.seed.withValues(alpha: isDark ? 0.22 : 0.18)
                    : Colors.black.withValues(alpha: isDark ? 0.12 : 0.03),
                blurRadius: focused ? 14 : 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextFormField(
            controller: _controller,
            focusNode: _focus,
            enabled: widget.enabled,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            textInputAction: _multiline
                ? TextInputAction.newline
                : widget.textInputAction,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            autofillHints: widget.autofillHints,
            textCapitalization: widget.textCapitalization,
            inputFormatters: widget.inputFormatters,
            onFieldSubmitted: widget.onSubmitted,
            obscureText: widget.obscureText,
            autocorrect: !_plainInput,
            enableSuggestions: !_plainInput,
            smartDashesType: _plainInput
                ? SmartDashesType.disabled
                : SmartDashesType.enabled,
            cursorColor: scheme.onSurface,
            cursorWidth: 1.6,
            cursorRadius: const Radius.circular(1),
            textAlignVertical: _multiline
                ? TextAlignVertical.top
                : TextAlignVertical.center,
            scrollPadding: const EdgeInsets.all(80),
            onTapOutside: (_) => _focus.unfocus(),
            style: theme.textTheme.bodyLarge?.copyWith(
              height: _multiline ? 1.45 : 1.25,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              filled: false,
              isDense: true,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(
                _icon == null ? 16 : 8,
                _multiline ? 14 : 16,
                8,
                _multiline ? 14 : 16,
              ),
              prefixIcon: _icon == null
                  ? null
                  : Icon(_icon, size: 20, color: scheme.onSurfaceVariant),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 44,
                minHeight: 44,
              ),
              suffixIcon: _controller.text.isEmpty || !widget.enabled
                  ? null
                  : IconButton(
                      tooltip: 'Clear',
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        _controller.clear();
                        widget.onChanged?.call('');
                        _focus.requestFocus();
                      },
                      icon: Icon(
                        Icons.cancel_rounded,
                        size: 18,
                        color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
                      ),
                    ),
              hintStyle: theme.textTheme.bodyLarge?.copyWith(
                color: scheme.onSurfaceVariant.withValues(alpha: 0.72),
                height: _multiline ? 1.45 : 1.25,
              ),
            ),
          ),
        ),
        if (hasError || widget.helperText != null) ...[
          const SizedBox(height: 6),
          Text(
            widget.errorText ?? widget.helperText!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: hasError ? scheme.error : scheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}
