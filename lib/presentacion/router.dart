import 'package:go_router/go_router.dart';
import 'menu/menu_screen.dart';
import 'registro_responsable/registrar_responsable_screen.dart';
import 'registro_adoptante/registrar_adoptante_screen.dart';
import 'registro_mascota/registrar_mascota_screen.dart';
import 'lista_mascotas/lista_mascotas_screen.dart';
import 'detalle_mascota/detalle_mascota_screen.dart';
import 'refugio/refugio_screen.dart';

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
    GoRoute(
      path: '/detalle_mascota',
      name: 'detalle_mascota',
      builder: (context, state) {
        final mascota = state.extra as dynamic;
        return DetalleMascotaScreen(mascota: mascota);
      },
    ),
    GoRoute(
      path: '/refugio',
      name: 'refugio',
      builder: (context, state) => const RefugioScreen(),
    ),
  ],
);
