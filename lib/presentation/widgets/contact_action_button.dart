import 'package:flutter/material.dart';

import '../../core/theme/app_theme_colors.dart';
import '../../core/theme/app_colors.dart';
import 'circular_icon_button.dart';

class ContactActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final double size;

  const ContactActionButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeColors>()!;

    return CircularIconButton(
      icon: icon,
      onTap: onTap,
      size: size,
      iconSize: size * 0.5,
      elevation: 0,
        backgroundColor: colors.glow,
        iconColor: AppColors.primary,
    );
  }
}
