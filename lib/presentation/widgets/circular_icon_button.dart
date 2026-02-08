import 'package:flutter/material.dart';
import '../../core/theme/app_theme_colors.dart';

class CircularIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final double iconSize;
  final double elevation;

  const CircularIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.iconColor,
    this.size = 40,
    this.iconSize = 24,
    this.elevation = 8,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeColors>()!;
    final bg = backgroundColor ?? colors.primary;
    final fg = iconColor ?? Colors.white;

    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size / 2),
      ),
      color: bg,
      shadowColor: Colors.black.withOpacity(0.2),
      child: InkWell(
        borderRadius: BorderRadius.circular(size / 2),
        onTap: onTap,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: Icon(
              icon,
              color: fg,
              size: iconSize,
            ),
          ),
        ),
      ),
    );
  }
}
