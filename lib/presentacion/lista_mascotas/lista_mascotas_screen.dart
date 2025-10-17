import 'package:flutter/material.dart';

class ListaMascotasScreen extends StatelessWidget {
  const ListaMascotasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Por ahora mostramos una lista de ejemplo estática. En una implementación
    // real, se obtendrían las mascotas desde el repositorio.
    final mascotasEjemplo = [
      'Firulais - Perro - 3 años',
      'Michi - Gato - 2 años',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Mascotas disponibles')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: mascotasEjemplo.length,
        itemBuilder:
            (context, index) => Card(
              child: ListTile(
                title: Text(mascotasEjemplo[index]),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Adoptar'),
                ),
              ),
            ),
      ),
    );
  }
}
