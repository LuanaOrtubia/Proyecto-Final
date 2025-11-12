import '../dominio/entidades/mascota.dart';
import '../dominio/entidades/adoptante_de_mascota.dart';
import '../dominio/repositorios/repositorio_de_mascota.dart';

/// Implementación en memoria de `RepositorioDeMascota`.
class AdaptadorDeMascotaEnMemoria implements RepositorioDeMascota {
  final List<Mascota> _almacen = [];

  AdaptadorDeMascotaEnMemoria();

  @override
  Future<List<Mascota>> obtenerMascotas() async {
    // retornar una copia para evitar modificaciones externas
    return List<Mascota>.from(_almacen);
  }

  @override
  Future<void> registrarMascota(Mascota mascota) async {
    // La imagen se proporciona desde la UI (subida por el responsable). Solo
    // guardamos la URL/path que venga en la entidad.
    final m = Mascota(
      esPerro: mascota.esPerro,
      nombre: mascota.nombre,
      edad: mascota.edad,
      esMacho: mascota.esMacho,
      tamanio: mascota.tamanio,
      observaciones: mascota.observaciones,
      imageUrl: mascota.imageUrl,
    );

    _almacen.add(m);
  }

  @override
  Future<void> adoptarMascota(AdoptanteDeMascota adoptante) async {
    // Lógica simple: si hay mascotas en el almacen, asignar la primera al adoptante
    if (_almacen.isNotEmpty) {
      //Comprueba si hay mascotas disponibles
      _almacen.removeAt(0); //Elimina la primera mascota del almacen
    }
    // Si no hay mascotas, no hace nada (comportamiento original)
  }
}
