import 'package:flutter/material.dart';
import 'dart:io';

import 'package:proyecto_final/adaptadores/injection.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_final/dominio/repositorios/repositorio_de_mascota.dart';
import 'package:proyecto_final/dominio/entidades/mascota.dart';
// imports anteriores eliminados al restaurar comportamiento original

class ListaMascotasScreen extends StatefulWidget {
  const ListaMascotasScreen({super.key});

  @override
  State<ListaMascotasScreen> createState() => _ListaMascotasScreenState();
}

class _ListaMascotasScreenState extends State<ListaMascotasScreen> {
  late Future<List<Mascota>> _futureMascotas;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    final repo = getIt<RepositorioDeMascota>();
    _futureMascotas = repo.obtenerMascotas();
  }

  Future<void> _refresh() async {
    _load();
    final repo = getIt<RepositorioDeMascota>();
    final mascotas = await repo.obtenerMascotas();
    setState(() {
      _futureMascotas = Future.value(mascotas);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mascotas disponibles'),
        actions: [
          TextButton(
            onPressed: () => context.go('/'),
            child: const Text('Menu', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: FutureBuilder<List<Mascota>>(
        future: _futureMascotas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final mascotas = snapshot.data ?? [];

          if (mascotas.isEmpty) {
            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Center(child: Text('No hay mascotas disponibles')),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: mascotas.length,
              itemBuilder: (context, index) {
                final m = mascotas[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Imagen y título
                        Row(
                          children: [
                            if (m.imageUrl != null && m.imageUrl!.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: m.imageUrl!.startsWith('http')
                                    ? Image.network(
                                        m.imageUrl!,
                                        width: 100,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        File(m.imageUrl!),
                                        width: 100,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                              )
                            else
                              Container(
                                width: 100,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: const Center(child: Icon(Icons.pets, size: 36)),
                              ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${m.nombre} - ${m.esPerro ? 'Perro' : 'Gato'}', style: Theme.of(context).textTheme.titleMedium),
                                  const SizedBox(height: 4),
                                  Text('Edad: ${m.edad}, Tamaño: ${m.tamanio}'),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text('Adoptar'),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // Botón 'Más información'
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            onPressed: () => context.push('/detalle_mascota', extra: m),
                            icon: const Icon(Icons.info_outline),
                            label: const Text('Más información'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
