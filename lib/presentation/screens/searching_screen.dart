import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/theme/app_theme_colors.dart';
import '../widgets/app_bottom_sheet.dart';
import '../widgets/primary_button.dart';
import '../widgets/section_title.dart';
import 'waiting_screen.dart';

class SearchingScreen extends StatefulWidget {
  const SearchingScreen({super.key});

  @override
  State<SearchingScreen> createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen> {
  Timer? _timer;
  int _elapsedSeconds = 0;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _elapsedSeconds += 1;
      });
      if (_elapsedSeconds >= 5) {
        _goToWaiting();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _goToWaiting() {
    if (_navigated) return;
    _navigated = true;
    _stopTimer();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const WaitingScreen(),
      ),
    );
  }

  String _formatElapsed(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeColors>()!;
    final sheetTheme = Theme.of(context).copyWith(
      scaffoldBackgroundColor: colors.primary,
      extensions: [
        colors.copyWith(
          text: Colors.white,
          background: colors.primary,
          box: colors.primary,
        ),
      ],
    );

    return Scaffold(
      backgroundColor: colors.secondary,
      body: Stack(
        children: [
          Container(color: colors.secondary),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Theme(
              data: sheetTheme,
              child: AppBottomSheet(
                draggable: false,
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 4),
                    const SectionTitle(
                      text: 'Estamos buscando un pavill cerca a tu',
                      secondLine: 'ubicacion',
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _formatElapsed(_elapsedSeconds),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 16),
                    PrimaryButton(
                      text: 'Cancelar',
                      variant: ButtonVariant.secondary,
                      onPressed: () {
                        _stopTimer();
                        Navigator.of(context).maybePop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
