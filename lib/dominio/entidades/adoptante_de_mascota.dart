class AdoptanteDeMascota {
  final int dni;
  final String nombre;
  final String apellido;
  final String correo;

  AdoptanteDeMascota({
    required this.dni,
    required this.nombre,
    required this.apellido,
    required this.correo,
  });

  @override
  String toString() {
    return 'AdoptanteDeMascota(DNI: $dni, nombre: $nombre, apellido: $apellido, correo: $correo)';
  }
}
