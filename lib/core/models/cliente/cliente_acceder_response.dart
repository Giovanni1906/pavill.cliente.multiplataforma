class ClienteAccederResponse {
  final String? clienteNacionalidadPais;
  final String? clienteAfiliadoNumeroDocumento;
  final String? clienteNacionalidadOpcion;
  final String? clienteAfiliadoNombre;
  final String? clienteCelular;
  final String? respuesta;
  final String? empresaNombre;
  final String? mensajesCorreoEnvio;
  final String? clienteAfiliadoDetalleFechaInicio;
  final String? clientePerfil;
  final String? clienteAfiliadoDetalleNumeroDocumento;
  final String? clienteAlias;
  final String? clienteId;
  final String? mensaje;
  final String? clienteEmail;
  final String? empresaFoto;
  final String? clienteNacionalidadNombre;
  final String? clienteAfiliadoDetalleId;
  final String? clienteNombre;
  final String? clienteContrasena;
  final String? clienteNumeroDocumento;
  final String? clienteCategoriaNombre;
  final String? clienteNacionalidadId;
  final String? tieneAfiliacion;
  final String? identificador;
  final String? empresaId;
  final String? clienteCategoriaId;
  final String? clienteAfiliadoId;

  const ClienteAccederResponse({
    this.clienteNacionalidadPais,
    this.clienteAfiliadoNumeroDocumento,
    this.clienteNacionalidadOpcion,
    this.clienteAfiliadoNombre,
    this.clienteCelular,
    this.respuesta,
    this.empresaNombre,
    this.mensajesCorreoEnvio,
    this.clienteAfiliadoDetalleFechaInicio,
    this.clientePerfil,
    this.clienteAfiliadoDetalleNumeroDocumento,
    this.clienteAlias,
    this.clienteId,
    this.mensaje,
    this.clienteEmail,
    this.empresaFoto,
    this.clienteNacionalidadNombre,
    this.clienteAfiliadoDetalleId,
    this.clienteNombre,
    this.clienteContrasena,
    this.clienteNumeroDocumento,
    this.clienteCategoriaNombre,
    this.clienteNacionalidadId,
    this.tieneAfiliacion,
    this.identificador,
    this.empresaId,
    this.clienteCategoriaId,
    this.clienteAfiliadoId,
  });

  static String? _asString(dynamic value) => value?.toString();

  factory ClienteAccederResponse.fromJson(Map<String, dynamic> json) {
    return ClienteAccederResponse(
      clienteNacionalidadPais: _asString(json["ClienteNacionalidadPais"]),
      clienteAfiliadoNumeroDocumento:
          _asString(json["ClienteAfiliadoNumeroDocumento"]),
      clienteNacionalidadOpcion: _asString(json["ClienteNacionalidadOpcion"]),
      clienteAfiliadoNombre: _asString(json["ClienteAfiliadoNombre"]),
      clienteCelular: _asString(json["ClienteCelular"]),
      respuesta: _asString(json["Respuesta"]),
      empresaNombre: _asString(json["EmpresaNombre"]),
      mensajesCorreoEnvio: _asString(json["MensajesCorreoEnvio"]),
      clienteAfiliadoDetalleFechaInicio:
          _asString(json["ClienteAfiliadoDetalleFechaInicio"]),
      clientePerfil: _asString(json["ClientePerfil"]),
      clienteAfiliadoDetalleNumeroDocumento:
          _asString(json["ClienteAfiliadoDetalleNumeroDocumento"]),
      clienteAlias: _asString(json["ClienteAlias"]),
      clienteId: _asString(json["ClienteId"]),
      mensaje: _asString(json["Mensaje"]),
      clienteEmail: _asString(json["ClienteEmail"]),
      empresaFoto: _asString(json["EmpresaFoto"]),
      clienteNacionalidadNombre: _asString(json["ClienteNacionalidadNombre"]),
      clienteAfiliadoDetalleId: _asString(json["ClienteAfiliadoDetalleId"]),
      clienteNombre: _asString(json["ClienteNombre"]),
      clienteContrasena: _asString(json["ClienteContrasena"]),
      clienteNumeroDocumento: _asString(json["ClienteNumeroDocumento"]),
      clienteCategoriaNombre: _asString(json["ClienteCategoriaNombre"]),
      clienteNacionalidadId: _asString(json["ClienteNacionalidadId"]),
      tieneAfiliacion: _asString(json["TieneAfiliacion"]),
      identificador: _asString(json["Identificador"]),
      empresaId: _asString(json["EmpresaId"]),
      clienteCategoriaId: _asString(json["ClienteCategoriaId"]),
      clienteAfiliadoId: _asString(json["ClienteAfiliadoId"]),
    );
  }
}
