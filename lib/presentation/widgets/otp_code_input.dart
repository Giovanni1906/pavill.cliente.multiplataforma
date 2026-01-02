import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_theme_colors.dart';

class OtpCodeInput extends StatefulWidget {
  final int length;
  final void Function(String code) onChanged;
  final void Function(String code) onCompleted;

  const OtpCodeInput({
    super.key,
    this.length = 4, // 4 o 6 normalmente
    required this.onChanged,
    required this.onCompleted,
  });

  @override
  State<OtpCodeInput> createState() => _OtpCodeInputState();
}

class _OtpCodeInputState extends State<OtpCodeInput> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;
  late final List<FocusNode> _keyboardFocusNodes;


  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
    _keyboardFocusNodes =
        List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    for (final k in _keyboardFocusNodes) {
      k.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty) {
      _controllers[index].text = value.substring(value.length - 1);
      _controllers[index].selection =
          const TextSelection.collapsed(offset: 1);

      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      }
    }

    // 🔄 SIEMPRE enviar el código actual
    final code = _controllers.map((c) => c.text).join();
    widget.onChanged(code);

    // ✅ Solo cuando esté completo
    final isComplete = _controllers.every((c) => c.text.isNotEmpty);
    if (isComplete) {
      widget.onCompleted(code);
    }
  }


  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeColors>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) {
        return Container(
          width: 48,
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: colors.primary,
                width: 2,
              ),
            ),
          ),
          child: KeyboardListener(
            focusNode: _keyboardFocusNodes[index],
            onKeyEvent: (event) {
              if (event is! KeyDownEvent) return;

              // ⬅️ BACKSPACE (ya lo tenías bien)
              if (event.logicalKey == LogicalKeyboardKey.backspace) {
                if (_controllers[index].text.isEmpty && index > 0) {
                  _controllers[index - 1].clear();
                  _focusNodes[index - 1].requestFocus();
                }
                return;
              }

              // 🔢 DIGITOS 0–9
              final keyLabel = event.logicalKey.keyLabel;
              final isDigit = RegExp(r'^[0-9]$').hasMatch(keyLabel);

              if (isDigit) {
                // Si este campo YA tiene número → pasar al siguiente
                if (_controllers[index].text.isNotEmpty &&
                    index < widget.length - 1) {
                  _controllers[index + 1].text = keyLabel;
                  _controllers[index + 1].selection =
                      const TextSelection.collapsed(offset: 1);
                  _focusNodes[index + 1].requestFocus();
                }
              }
            },
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: colors.text,
              ),
              decoration: const InputDecoration(
                counterText: '',
                border: InputBorder.none,
              ),
              onChanged: (value) => _onChanged(index, value),
            ),
          ),
        );
      }),
    );
  }
}
