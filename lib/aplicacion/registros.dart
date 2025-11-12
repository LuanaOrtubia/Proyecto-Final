import '../dominio/entidades/mascota.dart';
import '../dominio/entidades/adoptante_de_mascota.dart';
import '../dominio/repositorios/repositorio_de_mascota.dart';

class RegistrarMascota {
  final RepositorioDeMascota repositorio;

  RegistrarMascota(this.repositorio);

  Future<void> ejecutar(Mascota mascota) async {
    // Validaciones simples
    if (mascota.nombre.isEmpty) {
      throw ArgumentError('Nombre de mascota requerido');
    }
    if (mascota.edad.trim().isEmpty) {
      throw ArgumentError('Edad inválida');
    }

    // Llamada al repositorio
    await repositorio.registrarMascota(mascota);
  }
}

class AdoptarMascota {
  final RepositorioDeMascota repositorio;

  AdoptarMascota(this.repositorio);

  Future<void> ejecutar(AdoptanteDeMascota adoptante) async {
    // Validaciones
    if (adoptante.dni <= 0) {
      throw ArgumentError('DNI debe ser un entero positivo');
    }
    final correoValido = _validarCorreo(adoptante.correo);
    if (!correoValido) {
      throw ArgumentError('Correo inválido');
    }

    // Llamada al repositorio
    await repositorio.adoptarMascota(adoptante);
  }

  bool _validarCorreo(String correo) {
    final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}");
    return regex.hasMatch(correo);
  }
}
