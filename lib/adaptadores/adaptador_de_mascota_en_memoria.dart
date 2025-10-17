import '../dominio/entidades/mascota.dart';
import '../dominio/entidades/responsable_de_mascota.dart';
import '../dominio/entidades/adoptante_de_mascota.dart';
import '../dominio/repositorios/repositorio_de_mascota.dart';

/// Implementación en memoria de `RepositorioDeMascota`.
///
/// Nota: Para el propósito de ejemplo, `registrarMascota` crea una Mascota
/// con datos por defecto y nombre basado en el responsable. En una
/// implementación real, probablemente recibirías una `Mascota` completa.
class AdaptadorDeMascotaEnMemoria implements RepositorioDeMascota {
  final List<Mascota> _almacen = [];

  AdaptadorDeMascotaEnMemoria();

  @override
  Future<List<Mascota>> obtenerMascotas() async {
    // retornar una copia para evitar modificaciones externas
    return List<Mascota>.from(_almacen);
  }

  @override
  Future<void> registrarMascota(ResponsableDeMascota responsable) async {
    // Crear una mascota de ejemplo usando datos del responsable
    final nueva = Mascota(
      especie: 'desconocida',
      nombre: 'Mascota_de_${responsable.nombre}_${responsable.dni}',
      edad: 0,
      raza: 'desconocida',
      sexo: 'desconocido',
    );

    _almacen.add(nueva);
  }

  @override
  Future<void> adoptarMascota(AdoptanteDeMascota adoptante) async {
    // Lógica simple: si hay mascotas en el almacen, asignar la primera al adoptante
    if (_almacen.isNotEmpty) {
      _almacen.removeAt(0);
    }
    // Si no hay mascotas, no hace nada (comportamiento original)
  }
}
