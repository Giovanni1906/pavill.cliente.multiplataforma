import 'package:flutter/material.dart';

@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final Color primary;
  final Color icon;
  final Color secondary;
  final Color text;
  final Color background;
  final Color box;
  final Color glow;
  final Color shadow;
  final Color slowPrimary;
  final Color green;

  const AppThemeColors({
    required this.primary,
    required this.icon,
    required this.secondary,
    required this.text,
    required this.background,
    required this.box,
    required this.glow,
    required this.shadow,
    required this.slowPrimary,
    required this.green,
  });

  @override
  AppThemeColors copyWith({
    Color? primary,
    Color? icon,
    Color? secondary,
    Color? text,
    Color? background,
    Color? box,
    Color? glow,
    Color? shadow, 
    Color? slowPrimary,
    Color? green,
  }) {
    return AppThemeColors(
      primary: primary ?? this.primary,
      icon: icon ?? this.icon,
      secondary: secondary ?? this.secondary,
      text: text ?? this.text,
      background: background ?? this.background,
      box: box ?? this.box,
      glow: glow ?? this.glow,
      shadow: shadow ?? this.shadow,
      slowPrimary: slowPrimary ?? this.slowPrimary,
      green: green ?? this.green,
    );
  }

  @override
  AppThemeColors lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) return this;
    return AppThemeColors(
      primary: Color.lerp(primary, other.primary, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      text: Color.lerp(text, other.text, t)!,
      background: Color.lerp(background, other.background, t)!,
      box: Color.lerp(box, other.box, t)!,
      glow: Color.lerp(glow, other.glow, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      slowPrimary: Color.lerp(slowPrimary, other.slowPrimary, t)!, 
      green: Color.lerp(green, other.green, t)!,
    );
  }
}
