import 'package:flutter/material.dart';
import 'dart:io';

import 'package:go_router/go_router.dart';
import 'package:proyecto_final/dominio/entidades/mascota.dart';

class DetalleMascotaScreen extends StatelessWidget {
  final Mascota? mascota;

  const DetalleMascotaScreen({super.key, this.mascota});

  @override
  Widget build(BuildContext context) {
    final m = mascota;
    if (m == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalle')),
        body: const Center(child: Text('Mascota no encontrada')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(m.nombre)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen grande
            if (m.imageUrl != null && m.imageUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: m.imageUrl!.startsWith('http')
                    ? Image.network(
                        m.imageUrl!,
                        height: 240,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(m.imageUrl!),
                        height: 240,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              )
            else
              Container(
                height: 240,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Icon(Icons.pets, size: 80)),
              ),

            const SizedBox(height: 16),

            Text('${m.nombre} - ${m.esPerro ? 'Perro' : 'Gato'}', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Edad: ${m.edad} • Tamaño: ${m.tamanio} • Sexo: ${m.esMacho ? 'Macho' : 'Hembra'}'),
            const SizedBox(height: 12),
            Text('Observaciones:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(m.observaciones.isNotEmpty ? m.observaciones : 'Sin detalles adicionales.'),

            const SizedBox(height: 20),

            // Botón adoptame con icono de patita
            ElevatedButton.icon(
              onPressed: () => context.push('/refugio'),
              icon: const Icon(Icons.pets, size: 26),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text('¡Adóptame!', style: TextStyle(fontSize: 18)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
