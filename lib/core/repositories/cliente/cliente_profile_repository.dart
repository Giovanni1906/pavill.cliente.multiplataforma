import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../config/api_endpoints.dart';
import '../../models/cliente/cliente_editar_request.dart';
import '../../models/cliente/cliente_editar_response.dart';

/// Casos de uso del perfil del cliente.
///
/// Endpoints típicos aquí:
/// - cliente/editar
/// - cliente/obtener-registrados
class ClienteProfileRepository {
  final http.Client _client;

  ClienteProfileRepository({http.Client? client})
      : _client = client ?? http.Client();

  Future<ClienteEditarResponse> editar(
    ClienteEditarRequest request,
  ) async {
    final response = await _client.post(
      Uri.parse(ApiEndpoints.clienteEditar),
      headers: const {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: request.toMap(),
    );

    // Debug temporal para revisar respuesta del API en Flutter run.
    // ignore: avoid_print
    debugPrint("[cliente/editar] status=${response.statusCode}");
    // ignore: avoid_print
    debugPrint("[cliente/editar] body=${response.body}");

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception("Error HTTP ${response.statusCode}");
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic>) {
      throw Exception("Respuesta inesperada del servidor");
    }

    return ClienteEditarResponse.fromJson(decoded);
  }
}
