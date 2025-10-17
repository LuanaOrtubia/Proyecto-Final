import '../entidades/mascota.dart';
import '../entidades/responsable_de_mascota.dart';
import '../entidades/adoptante_de_mascota.dart';

abstract class RepositorioDeMascota {
  Future<List<Mascota>> obtenerMascotas();

  Future<void> registrarMascota(ResponsableDeMascota responsable);

  Future<void> adoptarMascota(AdoptanteDeMascota adoptante);
}
