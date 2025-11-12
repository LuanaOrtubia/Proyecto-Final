class Mascota {
  // true = perro, false = gato
  final bool esPerro; // especie
  final String nombre;
  final String edad;
  // true = macho, false = hembra
  final bool esMacho; // sexo
  final String tamanio;
  final String observaciones;
  final String? imageUrl;

  Mascota({
    required this.esPerro, // especie
    required this.nombre,
  required this.edad,
    required this.esMacho, // sexo
    required this.tamanio,
    required this.observaciones,
    this.imageUrl,
  });

  @override
  String toString() {
    final especieStr = esPerro ? 'Perro' : 'Gato';
    final sexoStr = esMacho ? 'Macho' : 'Hembra';
    return 'Mascota(especie: $especieStr, nombre: $nombre, edad: $edad, sexo: $sexoStr, tamaño: $tamanio, observaciones: $observaciones, imageUrl: $imageUrl)';
  }
}
