import '../entidades/mascota.dart';
import '../entidades/adoptante_de_mascota.dart';

abstract class RepositorioDeMascota {
  Future<List<Mascota>> obtenerMascotas();

  /// Registra una mascota en el repositorio.
  Future<void> registrarMascota(Mascota mascota);

  Future<void> adoptarMascota(AdoptanteDeMascota adoptante);
}
