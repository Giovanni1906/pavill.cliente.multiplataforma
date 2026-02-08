import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';

class BackExitHandler extends StatefulWidget {
  final Widget child;
  final bool blockBack;
  final Duration interval;
  final String message;

  const BackExitHandler({
    super.key,
    required this.child,
    this.blockBack = false,
    this.interval = const Duration(seconds: 2),
    this.message = 'Presiona nuevamente para salir',
  });

  @override
  State<BackExitHandler> createState() => _BackExitHandlerState();
}

class _BackExitHandlerState extends State<BackExitHandler> {
  DateTime? _lastBackPress;
  OverlayEntry? _overlayEntry;

  void _showExitMessage() {
    _overlayEntry?.remove();
    _overlayEntry = null;

    final overlay = Overlay.of(context);
    if (overlay == null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: 16,
          right: 16,
          bottom: 24,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.boxBackground.withOpacity(0.85),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Text(
                widget.message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.text,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(_overlayEntry!);

    Future.delayed(widget.interval, () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }

  Future<bool> _onWillPop() async {
    if (widget.blockBack) {
      return false;
    }

    final now = DateTime.now();
    if (_lastBackPress == null ||
        now.difference(_lastBackPress!) > widget.interval) {
      _lastBackPress = now;
      _showExitMessage();
      return false;
    }

    _overlayEntry?.remove();
    _overlayEntry = null;
    _lastBackPress = null;
    SystemNavigator.pop();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }
}
