import 'package:get_it/get_it.dart';
import '../adaptadores/adaptador_de_mascota_en_memoria.dart';
import '../dominio/repositorios/repositorio_de_mascota.dart';
import '../aplicacion/registros.dart';

final getIt = GetIt.instance;

void initInjection() {
  // Repositorio en memoria (implementación por defecto)
  getIt.registerLazySingleton<RepositorioDeMascota>(
    () => AdaptadorDeMascotaEnMemoria(),
  );

  // Casos de uso
  getIt.registerFactory(() => RegistrarMascota(getIt<RepositorioDeMascota>()));
  getIt.registerFactory(() => AdoptarMascota(getIt<RepositorioDeMascota>()));
}
