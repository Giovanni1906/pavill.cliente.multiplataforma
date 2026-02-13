import 'package:flutter/material.dart';

import '../../core/models/cliente/cliente_acceder_request.dart';
import '../../core/models/cliente/cliente_acceder_response.dart';
import '../../core/constants/responses/cliente_responses.dart';
import '../../core/repositories/cliente/cliente_auth_repository.dart';
import '../../core/services/session_storage.dart';

class LoginViewModel extends ChangeNotifier {
    LoginViewModel({
      ClienteAuthRepository? repository,
      SessionStorage? sessionStorage,
    })  : _repository = repository ?? ClienteAuthRepository(),
          _sessionStorage = sessionStorage ?? SessionStorage();

    final ClienteAuthRepository _repository;
    final SessionStorage _sessionStorage;

  bool isLoading = false;
  String? errorMessage;
  ClienteAccederResponse? clienteAccederResponse;

  Future<void> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      // ignore: avoid_print
      debugPrint("[login] llamando repository");
      final response = await _repository.acceder(
        ClienteAccederRequest(
          clienteEmail: email,
          clienteContrasena: password,
        ),
      );

      clienteAccederResponse = response;
      // ignore: avoid_print
      debugPrint("[login] respuesta=${response.respuesta}");

      switch (response.respuesta) {
        case ApiResponseCodes.clienteAccederOk:
          errorMessage = null;
          await _sessionStorage.saveClienteSession(response);
          break;
        case ApiResponseCodes.clienteAccederCredencialesInvalidas:
          errorMessage = "Credenciales incorrectas";
          break;
        case ApiResponseCodes.clienteAccederBloqueado:
          errorMessage = "Cliente bloqueado o desactivado";
          break;
        default:
          errorMessage = response.mensaje?.isNotEmpty == true
              ? response.mensaje
              : "Error desconocido";
      }
    } catch (error, stackTrace) {
      // ignore: avoid_print
      debugPrint("[login] error al iniciar sesión: $error");
      // ignore: avoid_print
      debugPrint("[login] stack: $stackTrace");
      errorMessage = "No se pudo iniciar sesión";
    }

    isLoading = false;
    notifyListeners();
  }
}
