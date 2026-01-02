import 'package:flutter/material.dart';

import 'general_input_field.dart';
import 'primary_button.dart';
import 'section_title.dart';

class LocationInputSheet extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final VoidCallback onSelectMap;

  const LocationInputSheet({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.onSelectMap,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String hintText,
    required TextEditingController controller,
    required VoidCallback onSelectMap,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: LocationInputSheet(
              title: title,
              hintText: hintText,
              controller: controller,
              onSelectMap: onSelectMap,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SectionTitle(text: title),
        const SizedBox(height: 16),
        GeneralInputField(
          icon: Icons.place_outlined,
          hintText: hintText,
          controller: controller,
          keyboardType: TextInputType.text,
          trailingIcon: Icons.delete_outline,
          onTrailingTap: controller.clear,
        ),
        const SizedBox(height: 12),
        PrimaryButton(
          text: "Seleccionar en el mapa",
          variant: ButtonVariant.secondary,
          onPressed: onSelectMap,
        ),
      ],
    );
  }
}
