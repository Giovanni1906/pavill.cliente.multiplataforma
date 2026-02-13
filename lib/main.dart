import 'package:flutter/material.dart';
import 'package:aplicativopavillcliente_flutter/presentation/screens/main_screen.dart';
import 'package:aplicativopavillcliente_flutter/presentation/screens/map_screen.dart';
import 'core/theme/app_theme.dart';
import 'core/services/session_storage.dart';

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
      home: const SessionGate(),
    );
  }
}

class SessionGate extends StatelessWidget {
  const SessionGate({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: SessionStorage().hasSession(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox.shrink();
        }

        final hasSession = snapshot.data == true;
        return hasSession ? const MapScreen() : const MainScreen();
      },
    );
  }
}
