class Mascota {
  final String especie;
  final String nombre;
  final int edad;
  final String raza;
  final String sexo;

  Mascota({
    required this.especie,
    required this.nombre,
    required this.edad,
    required this.raza,
    required this.sexo,
  });

  @override
  String toString() {
    return 'Mascota(especie: $especie, nombre: $nombre, edad: $edad, raza: $raza, sexo: $sexo)';
  }
}
