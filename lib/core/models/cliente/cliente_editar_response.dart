class ClienteEditarResponse {
  final String? postClienteId;
  final String? clienteId;
  final String? mensaje;
  final String? postClienteCelular;
  final String? clienteFotoAux;
  final String? postClienteEmail;
  final String? clienteEmail;
  final String? clienteCelular;
  final String? respuesta;
  final String? postClienteNombre;
  final String? clienteNombre;
  final String? clienteFoto;
  final String? postClienteFoto;
  final String? clienteContrasena;
  final String? clienteNumeroDocumento;
  final String? postClienteNumeroDocumento;
  final String? sistemaCdnUrlRemotoServidor;
  final String? clienteFotos;

  const ClienteEditarResponse({
    this.postClienteId,
    this.clienteId,
    this.mensaje,
    this.postClienteCelular,
    this.clienteFotoAux,
    this.postClienteEmail,
    this.clienteEmail,
    this.clienteCelular,
    this.respuesta,
    this.postClienteNombre,
    this.clienteNombre,
    this.clienteFoto,
    this.postClienteFoto,
    this.clienteContrasena,
    this.clienteNumeroDocumento,
    this.postClienteNumeroDocumento,
    this.sistemaCdnUrlRemotoServidor,
    this.clienteFotos,
  });

  static String? _asString(dynamic value) => value?.toString();

  factory ClienteEditarResponse.fromJson(Map<String, dynamic> json) {
    return ClienteEditarResponse(
      postClienteId: _asString(json["POST_ClienteId"]),
      clienteId: _asString(json["ClienteId"]),
      mensaje: _asString(json["Mensaje"]),
      postClienteCelular: _asString(json["POST_ClienteCelular"]),
      clienteFotoAux: _asString(json["ClienteFotoAux"]),
      postClienteEmail: _asString(json["POST_ClienteEmail"]),
      clienteEmail: _asString(json["ClienteEmail"]),
      clienteCelular: _asString(json["ClienteCelular"]),
      respuesta: _asString(json["Respuesta"]),
      postClienteNombre: _asString(json["POST_ClienteNombre"]),
      clienteNombre: _asString(json["ClienteNombre"]),
      clienteFoto: _asString(json["ClienteFoto"]),
      postClienteFoto: _asString(json["POST_ClienteFoto"]),
      clienteContrasena: _asString(json["ClienteContrasena"]),
      clienteNumeroDocumento: _asString(json["ClienteNumeroDocumento"]),
      postClienteNumeroDocumento:
          _asString(json["POST_ClienteNumeroDocumento"]),
      sistemaCdnUrlRemotoServidor:
          _asString(json["SistemaCDNUrlRemotoServidor"]),
      clienteFotos: _asString(json["cliente_fotos"]),
    );
  }
}
