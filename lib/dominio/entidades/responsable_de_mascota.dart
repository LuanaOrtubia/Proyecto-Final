class ResponsableDeMascota {
  final int dni;
  final String nombre;
  final String apellido;
  final String correo;

  ResponsableDeMascota({
    required this.dni,
    required this.nombre,
    required this.apellido,
    required this.correo,
  });

  @override
  String toString() {
    return 'ResponsableDeMascota(DNI: $dni, nombre: $nombre, apellido: $apellido, correo: $correo)';
  }
}
