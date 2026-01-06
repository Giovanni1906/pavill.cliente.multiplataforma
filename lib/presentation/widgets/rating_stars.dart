import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final int starCount;
  final double size;
  final Color filledColor;
  final Color emptyColor;

  const RatingStars({
    super.key,
    required this.rating,
    this.starCount = 5,
    this.size = 18,
    this.filledColor = Colors.amber,
    this.emptyColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    final clampedRating = rating.clamp(0, starCount).toDouble();
    final fullStars = clampedRating.floor();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(starCount, (index) {
        final isFilled = index < fullStars;
        return Icon(
          isFilled ? Icons.star : Icons.star_border,
          size: size,
          color: isFilled ? filledColor : emptyColor,
        );
      }),
    );
  }
}
