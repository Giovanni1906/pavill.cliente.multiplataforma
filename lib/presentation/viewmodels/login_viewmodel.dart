import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/config/api_endpoints.dart';

class LoginViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  Future<void> login(String dni, String password) async {
    isLoading = true;
    notifyListeners();

    final response = await http.post(
      Uri.parse(ApiEndpoints.login),
      body: {
        "Accion": "AccederConductor",
        "ConductorNumeroDocumento": dni,
        "ConductorContrasena": password,
      },
    );

    final data = jsonDecode(response.body);

    if (data == "C001") {
      // TODO: guardar sesión
      errorMessage = null;
    } else {
      errorMessage = "Credenciales incorrectas";
    }

    isLoading = false;
    notifyListeners();
  }
}
