import 'package:aplicativopavillcliente_flutter/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../core/services/location_permission_helper.dart';
import '../../core/utils/navigation/verify_flow_navigation.dart';
import '../widgets/primary_button.dart';
import 'login_screen.dart';
import 'verify_phone_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      LocationPermissionHelper.ensureLocationEnabled(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    child: Column(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'Pide seguridad,',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 4),

                        Text.rich(
                          TextSpan(
                            text: 'Pide un ',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Pavill',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  PrimaryButton(
                    onPressed: () {
                      print("pantalla verify-phone");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const VerifyPhoneScreen(
                            origin: VerifyOrigin.main,
                            action: VerifyAction.createAccount,
                          ),
                        ),
                      );
                    },
                    text: "Crear cuenta",

                  ),
                  PrimaryButton(
                    variant: ButtonVariant.alternative,
                    onPressed: () {
                      print("pantalla login");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                    text: "Iniciar sesion",
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '© 2025 Pavill. Todos los derechos reservados.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
