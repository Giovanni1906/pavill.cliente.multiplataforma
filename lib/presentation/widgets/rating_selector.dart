import 'package:flutter/material.dart';

import '../../core/theme/app_theme_colors.dart';

class RatingSelector extends StatelessWidget {
  final int rating;
  final int starCount;
  final double size;
  final ValueChanged<int> onChanged;

  const RatingSelector({
    super.key,
    required this.rating,
    required this.onChanged,
    this.starCount = 5,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeColors>()!;
    final filledColor = colors.primary;
    final emptyColor = colors.text.withOpacity(0.35);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(starCount, (index) {
        final starValue = index + 1;
        final isFilled = starValue <= rating;
        return IconButton(
          onPressed: () => onChanged(starValue),
          iconSize: size,
          padding: const EdgeInsets.symmetric(horizontal: 4),
          constraints: const BoxConstraints(),
          icon: Icon(
            isFilled ? Icons.star : Icons.star_border,
            color: isFilled ? filledColor : emptyColor,
          ),
        );
      }),
    );
  }
}
