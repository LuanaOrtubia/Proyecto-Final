import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistrarResponsableScreen extends StatefulWidget {
  const RegistrarResponsableScreen({super.key});

  @override
  State<RegistrarResponsableScreen> createState() =>
      _RegistrarResponsableScreenState();
}

class _RegistrarResponsableScreenState
    extends State<RegistrarResponsableScreen> {
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
      // Por ahora sólo navegamos al formulario de mascota. El guardado de la
      // mascota se realiza desde esa pantalla.
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Responsable registrado')));
      context.push('/registrar_mascota', extra: {'esResponsable': true});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar responsable')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Recomendación para iniciar sesión con Google
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Regístrate como responsable', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text('Te recomendamos iniciar sesión con tu cuenta de Google para facilitar el proceso y proteger tus datos.'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Inicio de sesión con Google no implementado')));
                          },
                          icon: const Icon(Icons.account_circle),
                          label: const Text('Iniciar sesión con Google'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                        ),
                        const SizedBox(width: 12),
                        TextButton(onPressed: () {}, child: const Text('Continuar sin Google')),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
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
                child: const Text('Siguiente: registrar mascota'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
