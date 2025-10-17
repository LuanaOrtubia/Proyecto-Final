import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    _especieController.dispose();
    _nombreController.dispose();
    _edadController.dispose();
    _razaController.dispose();
    _sexoController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Mascota registrada')));
      Navigator.popUntil(context, ModalRoute.withName('/'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final esResponsable = args != null && args['esResponsable'] == true;

    return Scaffold(
      appBar: AppBar(title: const Text('Registrar mascota')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (esResponsable)
                const Text('Registrando mascota como responsable'),
              TextFormField(
                controller: _especieController,
                decoration: const InputDecoration(labelText: 'Especie'),
                validator:
                    (v) => (v == null || v.isEmpty) ? 'Ingrese especie' : null,
              ),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator:
                    (v) => (v == null || v.isEmpty) ? 'Ingrese nombre' : null,
              ),
              TextFormField(
                controller: _edadController,
                decoration: const InputDecoration(labelText: 'Edad'),
                keyboardType: TextInputType.number,
                validator:
                    (v) =>
                        (v == null ||
                                int.tryParse(v) == null ||
                                int.parse(v) < 0)
                            ? 'Edad inválida'
                            : null,
              ),
              TextFormField(
                controller: _razaController,
                decoration: const InputDecoration(labelText: 'Raza'),
                validator:
                    (v) => (v == null || v.isEmpty) ? 'Ingrese raza' : null,
              ),
              TextFormField(
                controller: _sexoController,
                decoration: const InputDecoration(labelText: 'Sexo'),
                validator:
                    (v) => (v == null || v.isEmpty) ? 'Ingrese sexo' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Registrar mascota'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
