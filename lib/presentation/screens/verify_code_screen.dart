import 'package:flutter/material.dart';
import '../widgets/primary_button.dart';
import '../widgets/top_navbar.dart';
import '../widgets/section_title.dart';
import '../widgets/otp_code_input.dart';

import '../../core/utils/navigation/verify_code_navigation.dart';
import '../../core/utils/navigation/verify_flow_navigation.dart';


class VerifyCodeScreen extends StatefulWidget {
  final VerifyOrigin origin;
  final VerifyAction action;

  const VerifyCodeScreen({
    super.key,
    required this.origin,
    required this.action,
  });

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  String otpCode = '';
  bool isCodeComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopNavbar(
              title: "Verificar teléfono",
              onBack: () => Navigator.pop(context),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 48),

                    const SectionTitle(
                      text:
                          "El número de verificación ha sido enviado a su número por SMS",
                    ),

                    const SizedBox(height: 24),

                    OtpCodeInput(
                      length: 4,
                      onChanged: (code) {
                        setState(() {
                          otpCode = code; // 👈 siempre actualizado
                        });
                      },
                      onCompleted: (code) {
                        setState(() {
                          isCodeComplete = true;
                        });
                      },
                    ),

                    const SizedBox(height: 48),

                    PrimaryButton(
                      text: "Verificar código",
                      variant: ButtonVariant.secondary,
                      isEnabled: isCodeComplete,
                      onPressed: () {
                        print("Código verificado: $otpCode");
                        
                        print("Navegar a: ");
                        handleVerifyCodeNavigation(
                          context: context,
                          origin: widget.origin,
                          action: widget.action,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
