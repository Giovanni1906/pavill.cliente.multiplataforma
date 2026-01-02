import 'package:aplicativopavillcliente_flutter/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const PavillApp());
}

class PavillApp extends StatelessWidget {
  const PavillApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RadioTaxi Pavill',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // se adapta al modo del sistema
      home: const MainScreen(),
    );
  }
}
