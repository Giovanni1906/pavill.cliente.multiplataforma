import 'package:flutter/material.dart';
import '../../core/theme/app_theme_colors.dart';

class LinkText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final TextAlign align;
  final EdgeInsetsGeometry margin;

  const LinkText({
    super.key,
    required this.text,
    required this.onTap,
    this.align = TextAlign.center,
    this.margin = const EdgeInsets.only(bottom: 20),
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeColors>()!;

    return Container(
      margin: margin,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          textAlign: align,
          style: TextStyle(
            color: colors.slowPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 14,
            decoration: TextDecoration.underline, // opcional para simular enlace
          ),
        ),
      ),
    );
  }
}
