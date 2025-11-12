class Refugio {
  final String nombre;
  final String correo;
  final String telefono;
  final String direccion;

  const Refugio({
    required this.nombre,
    required this.correo,
    required this.telefono,
    required this.direccion,
  });

  static const defaultRefugio = Refugio(
    nombre: 'Patitas en la calle',
    correo: 'patitasenlacalle@gmail.com',
    telefono: '2622225688',
    direccion: 'Calle falsa Patitas en la Calle',
  );

  @override
  String toString() {
    return 'Refugio(nombre: $nombre, correo: $correo, telefono: $telefono, direccion: $direccion)';
  }
}
