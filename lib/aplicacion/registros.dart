import '../dominio/entidades/responsable_de_mascota.dart';
import '../dominio/entidades/adoptante_de_mascota.dart';
import '../dominio/repositorios/repositorio_de_mascota.dart';

class RegistrarMascota {
  final RepositorioDeMascota repositorio;

  RegistrarMascota(this.repositorio);

  Future<void> ejecutar(ResponsableDeMascota responsable) async {
    // Validaciones
    if (responsable.dni <= 0) {
      throw ArgumentError('DNI debe ser un entero positivo');
    }
    final correoValido = _validarCorreo(responsable.correo);
    if (!correoValido) {
      throw ArgumentError('Correo inválido');
    }

    // Llamada al repositorio
    await repositorio.registrarMascota(responsable);
  }

  bool _validarCorreo(String correo) {
    final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}");
    return regex.hasMatch(correo);
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
