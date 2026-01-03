import 'package:flutter/material.dart';
import '../../core/theme/app_theme_colors.dart'; // themas de colores
import '../../core/theme/app_colors.dart';       // colores fijos

class MultiLineInputField extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final int minLines;
  final int maxLines;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingTap;
  final IconData? trailingIconSecondary;
  final VoidCallback? onTrailingSecondaryTap;

  const MultiLineInputField({
    super.key,
    required this.icon,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.multiline,
    this.obscureText = false,
    this.minLines = 1,
    this.maxLines = 4,
    this.trailingIcon,
    this.onTrailingTap,
    this.trailingIconSecondary,
    this.onTrailingSecondaryTap,
  });

  @override
  State<MultiLineInputField> createState() => _MultiLineInputFieldState();
}

class _MultiLineInputFieldState extends State<MultiLineInputField> {
  late TextEditingController _controller;
  late bool _ownsController;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  @override
  void didUpdateWidget(covariant MultiLineInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _disposeControllerIfNeeded();
      _initController();
    }
  }

  void _initController() {
    if (widget.controller != null) {
      _controller = widget.controller!;
      _ownsController = false;
    } else {
      _controller = TextEditingController();
      _ownsController = true;
    }
    _controller.addListener(_handleTextChanged);
  }

  void _disposeControllerIfNeeded() {
    _controller.removeListener(_handleTextChanged);
    if (_ownsController) {
      _controller.dispose();
    }
  }

  void _handleTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _disposeControllerIfNeeded();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeColors>()!;
    final textStyle = TextStyle(
      fontSize: 14,
      color: colors.text,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: colors.box,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: colors.glow,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              widget.icon,
              color: AppColors.primary,
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final text = _controller.text;
                final displayText = text.isEmpty ? ' ' : text;
                final textPainter = TextPainter(
                  text: TextSpan(text: displayText, style: textStyle),
                  textDirection: Directionality.of(context),
                  maxLines: widget.maxLines,
                )..layout(maxWidth: constraints.maxWidth);
                final lineCount = textPainter.computeLineMetrics().length;
                final isMultiLine = lineCount > 1;

                return TextField(
                  controller: _controller,
                  keyboardType: widget.keyboardType,
                  obscureText: widget.obscureText,
                  minLines: widget.minLines,
                  maxLines: widget.maxLines,
                  style: textStyle,
                  textAlignVertical:
                      isMultiLine ? TextAlignVertical.top : TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: colors.text,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: isMultiLine
                        ? const EdgeInsets.only(top: 2)
                        : const EdgeInsets.symmetric(vertical: 6),
                  ),
                );
              },
            ),
          ),
          if (widget.trailingIcon != null ||
              widget.trailingIconSecondary != null)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.trailingIcon != null)
                  InkResponse(
                    onTap: widget.onTrailingTap,
                    radius: 18,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        widget.trailingIcon,
                        size: 22,
                        color: colors.text,
                      ),
                    ),
                  ),
                if (widget.trailingIconSecondary != null &&
                    widget.trailingIcon != null)
                  const SizedBox(width: 6),
                if (widget.trailingIconSecondary != null)
                  InkResponse(
                    onTap: widget.onTrailingSecondaryTap,
                    radius: 18,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        widget.trailingIconSecondary,
                        size: 22,
                        color: colors.text,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
