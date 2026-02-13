import 'package:shared_preferences/shared_preferences.dart';

import '../models/cliente/cliente_acceder_response.dart';
import '../models/cliente/cliente_session.dart';

class SessionStorage {
  static const _keyClienteId = 'cliente_id';
  static const _keyClienteEmail = 'cliente_email';
  static const _keyClienteAlias = 'cliente_alias';
  static const _keyClienteNombre = 'cliente_nombre';
  static const _keyClienteNumeroDocumento = 'cliente_numero_documento';
  static const _keyClienteCelular = 'cliente_celular';

  Future<void> saveClienteSession(ClienteAccederResponse response) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyClienteId, response.clienteId ?? '');
    await prefs.setString(_keyClienteEmail, response.clienteEmail ?? '');
    await prefs.setString(_keyClienteAlias, response.clienteAlias ?? '');
    await prefs.setString(_keyClienteNombre, response.clienteNombre ?? '');
    await prefs.setString(
      _keyClienteNumeroDocumento,
      response.clienteNumeroDocumento ?? '',
    );
    await prefs.setString(_keyClienteCelular, response.clienteCelular ?? '');
  }

  Future<bool> hasSession() async {
    final prefs = await SharedPreferences.getInstance();
    final clienteId = prefs.getString(_keyClienteId);
    return clienteId != null && clienteId.isNotEmpty;
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyClienteId);
    await prefs.remove(_keyClienteEmail);
    await prefs.remove(_keyClienteAlias);
    await prefs.remove(_keyClienteNombre);
    await prefs.remove(_keyClienteNumeroDocumento);
    await prefs.remove(_keyClienteCelular);
  }

  Future<String?> getClienteNombre() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_keyClienteNombre);
    return value?.isNotEmpty == true ? value : null;
  }

  Future<ClienteSession> getClienteSession() async {
    final prefs = await SharedPreferences.getInstance();
    return ClienteSession(
      id: _normalize(prefs.getString(_keyClienteId)),
      nombre: _normalize(prefs.getString(_keyClienteNombre)),
      email: _normalize(prefs.getString(_keyClienteEmail)),
      numeroDocumento: _normalize(
        prefs.getString(_keyClienteNumeroDocumento),
      ),
      celular: _normalize(prefs.getString(_keyClienteCelular)),
      alias: _normalize(prefs.getString(_keyClienteAlias)),
    );
  }

  Future<void> updateClienteProfile({
    required String numeroDocumento,
    required String nombre,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyClienteNumeroDocumento, numeroDocumento);
    await prefs.setString(_keyClienteNombre, nombre);
    await prefs.setString(_keyClienteEmail, email);
  }

  String? _normalize(String? value) {
    if (value == null || value.isEmpty) return null;
    return value;
  }
}
