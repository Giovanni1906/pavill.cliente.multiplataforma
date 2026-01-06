import 'package:flutter/material.dart';

import '../../core/theme/app_theme_colors.dart';
import 'checkbox_field.dart';
import 'multiline_input_field.dart';
import 'primary_button.dart';
import 'rating_selector.dart';
import 'section_title.dart';

class RatingDialog extends StatefulWidget {
  final String title;
  final String imageAsset;
  final String subtitle;
  final List<String> reasons;
  final String commentHint;
  final String actionText;
  final void Function(int rating, List<String> reasons, String comment) onSubmit;

  const RatingDialog({
    super.key,
    required this.title,
    required this.imageAsset,
    required this.subtitle,
    required this.reasons,
    required this.commentHint,
    required this.actionText,
    required this.onSubmit,
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String imageAsset,
    required String subtitle,
    required List<String> reasons,
    required String commentHint,
    required String actionText,
    required void Function(int rating, List<String> reasons, String comment)
        onSubmit,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: RatingDialog(
            title: title,
            imageAsset: imageAsset,
            subtitle: subtitle,
            reasons: reasons,
            commentHint: commentHint,
            actionText: actionText,
            onSubmit: onSubmit,
          ),
        );
      },
    );
  }

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  final TextEditingController _commentController = TextEditingController();
  final Set<int> _selectedReasons = <int>{};
  int _rating = 0;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _toggleReason(int index, bool? value) {
    setState(() {
      if (value == true) {
        _selectedReasons.add(index);
      } else {
        _selectedReasons.remove(index);
      }
    });
  }

  void _setRating(int rating) {
    setState(() {
      _rating = rating;
    });
  }

  void _submit() {
    final selectedLabels = _selectedReasons
        .map((index) => widget.reasons[index])
        .toList();
    Navigator.of(context).pop();
    widget.onSubmit(_rating, selectedLabels, _commentController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeColors>()!;
    final maxHeight = MediaQuery.of(context).size.height * 0.82;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkResponse(
                  onTap: () => Navigator.of(context).pop(),
                  radius: 18,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: colors.text.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              SectionTitle(text: widget.title),
              const SizedBox(height: 12),
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(widget.imageAsset),
                backgroundColor: colors.box,
              ),
              const SizedBox(height: 8),
              Text(
                widget.subtitle,
                style: TextStyle(
                  color: colors.text.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              RatingSelector(
                rating: _rating,
                onChanged: _setRating,
              ),
              const SizedBox(height: 12),
              Column(
                children: List.generate(
                  widget.reasons.length,
                  (index) => CheckboxField(
                    label: widget.reasons[index],
                    value: _selectedReasons.contains(index),
                    onChanged: (value) => _toggleReason(index, value),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              MultiLineInputField(
                icon: Icons.mode_edit_outline,
                hintText: widget.commentHint,
                controller: _commentController,
                minLines: 1,
                maxLines: 5,
              ),
              const SizedBox(height: 8),
              PrimaryButton(
                text: widget.actionText,
                variant: ButtonVariant.secondary,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
