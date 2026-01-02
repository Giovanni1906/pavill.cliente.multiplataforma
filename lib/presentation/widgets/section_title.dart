import 'package:flutter/material.dart';
import '../../core/theme/app_theme_colors.dart';

class SectionTitle extends StatelessWidget {
  final String text;
  final String? secondLine;
  final bool secondLineBold;
  final EdgeInsetsGeometry padding;

  const SectionTitle({
    super.key,
    required this.text,
    this.secondLine,
    this.secondLineBold = true,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeColors>()!;
    final baseStyle = TextStyle(
      fontSize: 16,              // tamaño tipo título
      fontWeight: FontWeight.bold,
      color: colors.text,        // color del texto según tema
    );

    return Padding(
      padding: padding,
      child: secondLine == null
          ? Text(
              text,
              textAlign: TextAlign.center, // centrado horizontal
              style: baseStyle,
            )
          : Text.rich(
              TextSpan(
                text: '$text\n',
                style: baseStyle.copyWith(fontWeight: FontWeight.normal),
                children: [
                  TextSpan(
                    text: secondLine!,
                    style: baseStyle.copyWith(
                      fontWeight:
                          secondLineBold ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
    );
  }
}
