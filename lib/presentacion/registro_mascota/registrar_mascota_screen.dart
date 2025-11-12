import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyecto_final/adaptadores/injection.dart';
import 'package:proyecto_final/aplicacion/registros.dart';
import 'package:proyecto_final/dominio/entidades/mascota.dart';

class RegistrarMascotaScreen extends StatefulWidget {
  const RegistrarMascotaScreen({super.key});

  @override
  State<RegistrarMascotaScreen> createState() => _RegistrarMascotaScreenState();
}

class _RegistrarMascotaScreenState extends State<RegistrarMascotaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _especieController = TextEditingController();
  final _nombreController = TextEditingController();
  final _edadController = TextEditingController();
  final _razaController = TextEditingController();
  final _sexoController = TextEditingController();
  final _observacionesController = TextEditingController();
  bool _isSaving = false;
  XFile? _pickedImage;
  bool _isPickingImage = false;

  // Preferir campos más amigables: opciones para especie y sexo
  String _especie = 'perro'; // 'perro' o 'gato'
  String _sexo = 'macho'; // 'macho' o 'hembra'

  @override
  void dispose() {
    _especieController.dispose();
    _nombreController.dispose();
    _edadController.dispose();
    _razaController.dispose();
    _sexoController.dispose();
    _observacionesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final mascota = Mascota(
      esPerro: _especie == 'perro',
      nombre: _nombreController.text,
      edad: _edadController.text,
      esMacho: _sexo == 'macho',
      tamanio: _razaController.text,
      observaciones: _observacionesController.text,
  imageUrl: _pickedImage?.path,
    );

    setState(() => _isSaving = true);
    final registrar = getIt<RegistrarMascota>();
    try {
      await registrar.ejecutar(mascota);
      if (!mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mascota registrada')));
  // Volver al menú principal después de guardar
  context.go('/');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Future<void> _pickImage() async {
    setState(() => _isPickingImage = true);
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? file = await picker.pickImage(source: ImageSource.gallery, maxWidth: 1200);
      if (file != null && mounted) setState(() => _pickedImage = file);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al seleccionar imagen: $e')));
    } finally {
      if (mounted) setState(() => _isPickingImage = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(title: const Text('Dar mascota')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Header visual llamativo
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    // Large pet logo
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
                      ),
                      child: const Icon(Icons.pets, color: Colors.orange, size: 38),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dar mascota', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text('Completa los datos de la mascota que deseas dar en adopción', style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                    // small adoption badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: const [Icon(Icons.favorite, color: Colors.green, size: 16), SizedBox(width: 6), Text('Adopción')],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Selector de imagen local (galería)
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_pickedImage != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(File(_pickedImage!.path), height: 180, fit: BoxFit.cover),
                      )
                    else
                      Container(
                        height: 180,
                        decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                        child: const Center(child: Icon(Icons.image, size: 64, color: Colors.grey)),
                      ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _isPickingImage ? null : _pickImage,
                          icon: _isPickingImage
                              ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                              : const Icon(Icons.photo_library),
                          label: Padding(padding: const EdgeInsets.symmetric(vertical: 10), child: Text(_isPickingImage ? 'Seleccionando...' : 'Seleccionar foto')),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                        ),
                        const SizedBox(width: 12),
                        if (_pickedImage != null)
                          Expanded(
                            child: Text(
                              _pickedImage!.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12, color: Colors.black54),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              // Especie (radio)
              Row(
                children: [
                  const Text('Especie:'),
                  const SizedBox(width: 12),
                  ChoiceChip(
                    label: const Text('Perro'),
                    selected: _especie == 'perro',
                    onSelected: (_) => setState(() => _especie = 'perro'),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('Gato'),
                    selected: _especie == 'gato',
                    onSelected: (_) => setState(() => _especie = 'gato'),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) => (v == null || v.isEmpty) ? 'Ingrese nombre' : null,
              ),
              TextFormField(
                controller: _edadController,
                decoration: const InputDecoration(labelText: 'Edad (ej: 3 meses, 2 años)'),
                keyboardType: TextInputType.text,
                validator: (v) => (v == null || v.isEmpty) ? 'Ingrese edad' : null,
              ),
              TextFormField(
                controller: _razaController,
                decoration: const InputDecoration(labelText: 'Tamaño / Raza'),
                validator: (v) => (v == null || v.isEmpty) ? 'Ingrese raza/tamaño' : null,
              ),

              const SizedBox(height: 12),
              // Sexo
              Row(
                children: [
                  const Text('Sexo:'),
                  const SizedBox(width: 12),
                  ChoiceChip(
                    label: const Text('Macho'),
                    selected: _sexo == 'macho',
                    onSelected: (_) => setState(() => _sexo = 'macho'),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('Hembra'),
                    selected: _sexo == 'hembra',
                    onSelected: (_) => setState(() => _sexo = 'hembra'),
                  ),
                ],
              ),

              const SizedBox(height: 12),
              TextFormField(
                controller: _observacionesController,
                decoration: const InputDecoration(labelText: 'Observaciones'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isSaving ? null : _submit,
                      icon: _isSaving
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Icon(Icons.save),
                      label: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Text(_isSaving ? 'Guardando...' : 'Guardar registro', style: const TextStyle(fontSize: 16)),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => context.go('/'),
                      icon: const Icon(Icons.home),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text('Menu', style: TextStyle(fontSize: 16)),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
