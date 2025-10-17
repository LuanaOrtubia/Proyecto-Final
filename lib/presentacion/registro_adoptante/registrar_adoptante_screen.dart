import 'package:flutter/material.dart';

class RegistrarAdoptanteScreen extends StatefulWidget {
  const RegistrarAdoptanteScreen({super.key});

  @override
  State<RegistrarAdoptanteScreen> createState() =>
      _RegistrarAdoptanteScreenState();
}

class _RegistrarAdoptanteScreenState extends State<RegistrarAdoptanteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _dniController = TextEditingController();
  final _correoController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _dniController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Adoptante registrado')));
      Navigator.pushNamed(context, '/lista_mascotas');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar adoptante')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator:
                    (v) => (v == null || v.isEmpty) ? 'Ingrese nombre' : null,
              ),
              TextFormField(
                controller: _apellidoController,
                decoration: const InputDecoration(labelText: 'Apellido'),
                validator:
                    (v) => (v == null || v.isEmpty) ? 'Ingrese apellido' : null,
              ),
              TextFormField(
                controller: _dniController,
                decoration: const InputDecoration(labelText: 'DNI'),
                keyboardType: TextInputType.number,
                validator:
                    (v) =>
                        (v == null ||
                                int.tryParse(v) == null ||
                                int.parse(v) <= 0)
                            ? 'DNI inválido'
                            : null,
              ),
              TextFormField(
                controller: _correoController,
                decoration: const InputDecoration(labelText: 'Correo'),
                validator:
                    (v) =>
                        (v == null ||
                                !RegExp(
                                  r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}",
                                ).hasMatch(v))
                            ? 'Correo inválido'
                            : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Ver mascotas para adoptar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
