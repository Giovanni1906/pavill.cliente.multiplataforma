import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../config/api_endpoints.dart';
import '../../models/cliente/cliente_acceder_request.dart';
import '../../models/cliente/cliente_acceder_response.dart';

/// Casos de uso de autenticación del cliente.
///
/// Endpoints típicos aquí:
/// - cliente/acceder
/// - cliente/registrar
/// - cliente/recuperar
/// - cliente/editar-contrasena
/// - cliente/verificar-celular
class ClienteAuthRepository {
  final http.Client _client;

  ClienteAuthRepository({http.Client? client}) : _client = client ?? http.Client();

  Future<ClienteAccederResponse> acceder(
    ClienteAccederRequest request,
  ) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiEndpoints.clienteAcceder),
        headers: const {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: request.toMap(),
      );

      // Debug temporal para revisar respuesta del API en Flutter run.
      // ignore: avoid_print
      debugPrint("[cliente/acceder] status=${response.statusCode}");
      // ignore: avoid_print
      debugPrint("[cliente/acceder] body=${response.body}");

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception("Error HTTP ${response.statusCode}");
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        throw Exception("Respuesta inesperada del servidor");
      }

      return ClienteAccederResponse.fromJson(decoded);
    } catch (error, stackTrace) {
      // ignore: avoid_print
      debugPrint("[cliente/acceder] error: $error");
      // ignore: avoid_print
      debugPrint("[cliente/acceder] stack: $stackTrace");
      rethrow;
    }
  }
}
