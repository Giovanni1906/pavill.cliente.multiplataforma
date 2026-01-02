import 'package:flutter/material.dart';
import '../widgets/general_input_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/top_navbar.dart';
import '../widgets/section_title.dart';
import 'main_screen.dart';
import 'verify_code_screen.dart';

import '../../core/utils/navigation/verify_flow_navigation.dart';

class VerifyPhoneScreen extends StatelessWidget {
  const VerifyPhoneScreen({
    super.key,
    required this.origin,
    required this.action,
  });

  final VerifyOrigin origin;
  final VerifyAction action;

  @override
  Widget build(BuildContext context) {
    final verifyPhoneController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true, //permite que se ajuste con el teclado
      body: SafeArea(
        child: Column(
          children: [
            // 🟣 NAVBAR SUPERIOR
            TopNavbar(
              title: "Volver al inicio",
              onBack: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const MainScreen(),
                  ),
                );
              },
            ),

            // 🟩 CONTENIDO PRINCIPAL
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 48),

                      SectionTitle(text: "Ingrese su numero de celular para recibir el código de verificación"),

                      const SizedBox(height: 24),

                      // Campo de teléfono
                      GeneralInputField(
                        icon: Icons.phone_iphone_rounded,
                        hintText: 'Celular',
                        controller: verifyPhoneController,
                        keyboardType: TextInputType.phone,
                      ),

                      const SizedBox(height: 12),

                      // Botón secundario
                      PrimaryButton(
                        text: "Enviar código",
                        variant: ButtonVariant.secondary,
                        onPressed: () {
                          print("envía código de verificación");
                          
                          print("pasa a verify code");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => VerifyCodeScreen(
                                origin: origin,
                                action: action,
                              ),
                            ),
                          );
                        },
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
