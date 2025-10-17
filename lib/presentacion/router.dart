import 'package:go_router/go_router.dart';
import 'menu/menu_screen.dart';
import 'registro_responsable/registrar_responsable_screen.dart';
import 'registro_adoptante/registrar_adoptante_screen.dart';
import 'registro_mascota/registrar_mascota_screen.dart';
import 'lista_mascotas/lista_mascotas_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'menu',
      builder: (context, state) => const MenuScreen(),
    ),
    GoRoute(
      path: '/registrar_responsable',
      name: 'registrar_responsable',
      builder: (context, state) => const RegistrarResponsableScreen(),
    ),
    GoRoute(
      path: '/registrar_adoptante',
      name: 'registrar_adoptante',
      builder: (context, state) => const RegistrarAdoptanteScreen(),
    ),
    GoRoute(
      path: '/registrar_mascota',
      name: 'registrar_mascota',
      builder: (context, state) => const RegistrarMascotaScreen(),
    ),
    GoRoute(
      path: '/lista_mascotas',
      name: 'lista_mascotas',
      builder: (context, state) => const ListaMascotasScreen(),
    ),
  ],
);
