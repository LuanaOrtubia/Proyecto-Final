import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menú')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => context.push('/registrar_responsable'),
              child: const Text('Registrar responsable de mascota'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.push('/registrar_adoptante'),
              child: const Text('Registrar adoptante'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.push('/lista_mascotas'),
              child: const Text('Ver mascotas (si eres adoptante)'),
            ),
          ],
        ),
      ),
    );
  }
}
