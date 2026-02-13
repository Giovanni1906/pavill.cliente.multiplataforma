import 'package:flutter/material.dart';

import '../../core/constants/responses/cliente_responses.dart';
import '../../core/models/cliente/cliente_editar_request.dart';
import '../../core/models/cliente/cliente_editar_response.dart';
import '../../core/models/cliente/cliente_session.dart';
import '../../core/repositories/cliente/cliente_profile_repository.dart';
import '../../core/services/session_storage.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel({
    ClienteProfileRepository? repository,
    SessionStorage? sessionStorage,
  })  : _repository = repository ?? ClienteProfileRepository(),
        _sessionStorage = sessionStorage ?? SessionStorage();

  final ClienteProfileRepository _repository;
  final SessionStorage _sessionStorage;

  bool isLoading = false;
  String? errorMessage;
  String? successMessage;
  ClienteSession? session;

  Future<void> loadSession() async {
    session = await _sessionStorage.getClienteSession();
    notifyListeners();
  }

  Future<void> actualizarPerfil({
    required String numeroDocumento,
    required String nombre,
    required String email,
  }) async {
    final clienteId = session?.id;
    final clienteCelular = session?.celular ?? '';

    if (clienteId == null || clienteId.isEmpty) {
      errorMessage = 'Sesión inválida.';
      successMessage = null;
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = null;
    successMessage = null;
    notifyListeners();

    try {
      final response = await _repository.editar(
        ClienteEditarRequest(
          clienteId: clienteId,
          clienteNumeroDocumento: numeroDocumento,
          clienteNombre: nombre,
          clienteEmail: email,
          clienteCelular: clienteCelular,
        ),
      );

      _handleEditarResponse(response, numeroDocumento, nombre, email);
    } catch (_) {
      errorMessage = 'No se pudo actualizar el perfil.';
    }

    isLoading = false;
    notifyListeners();
  }

  void _handleEditarResponse(
    ClienteEditarResponse response,
    String numeroDocumento,
    String nombre,
    String email,
  ) {
    switch (response.respuesta) {
      case ApiResponseCodes.clienteEditarOk:
        successMessage = 'Datos actualizados correctamente.';
        errorMessage = null;
        _sessionStorage.updateClienteProfile(
          numeroDocumento: numeroDocumento,
          nombre: nombre,
          email: email,
        );
        session = ClienteSession(
          id: session?.id,
          alias: session?.alias,
          celular: session?.celular,
          numeroDocumento: numeroDocumento,
          nombre: nombre,
          email: email,
        );
        break;
      case ApiResponseCodes.clienteEditarError:
        errorMessage = 'Fallo al actualizar los datos del cliente.';
        successMessage = null;
        break;
      case ApiResponseCodes.clienteEditarNoEncontrado:
        errorMessage = 'Cliente no encontrado.';
        successMessage = null;
        break;
      default:
        errorMessage = response.mensaje?.isNotEmpty == true
            ? response.mensaje
            : 'Error desconocido.';
        successMessage = null;
    }
  }
}
