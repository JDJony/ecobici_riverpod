import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'profile_provider.dart';
import 'profile_view_model.dart';

class ProfileFormView extends ConsumerStatefulWidget {
  const ProfileFormView({super.key});

  @override
  ConsumerState<ProfileFormView> createState() => _ProfileFormViewState();
}

class _ProfileFormViewState extends ConsumerState<ProfileFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _tokenController = TextEditingController();
  var _hideToken = true;
  var _appliedSavedValues = false;

  @override
  void dispose() {
    _nameController.dispose();
    _tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileVmProvider);
    _applySavedValues(profile);

    final isSaving = profile.status == ProfileStatus.saving;

    return Scaffold(
      appBar: AppBar(title: const Text('Guardar perfil')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'El nombre se guarda en Hive. El token se guarda cifrado con flutter_secure_storage.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      helperText: 'Se guarda en Hive',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Escribe un nombre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _tokenController,
                    obscureText: _hideToken,
                    decoration: InputDecoration(
                      labelText: 'Token secreto',
                      helperText: 'Se guarda en flutter_secure_storage',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        tooltip: _hideToken ? 'Mostrar token' : 'Ocultar token',
                        onPressed: () => setState(() => _hideToken = !_hideToken),
                        icon: Icon(
                          _hideToken ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Escribe un token';
                      }
                      return null;
                    },
                  ),
                  if (profile.errorMessage != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      profile.errorMessage!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: isSaving ? null : _submit,
                    child: isSaving
                        ? const SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Guardar'),
                  ),
                  if (profile.hasData) ...[
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () => context.pushNamed('profile-detail'),
                      child: const Text('Ver detalle'),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applySavedValues(ProfileState profile) {
    if (_appliedSavedValues || profile.status != ProfileStatus.ready) return;
    _appliedSavedValues = true;
    final name = profile.name;
    final token = profile.token;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (_nameController.text.isEmpty) _nameController.text = name;
      if (_tokenController.text.isEmpty) _tokenController.text = token;
    });
  }

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() != true) return;

    final saved = await ref
        .read(profileVmProvider.notifier)
        .save(name: _nameController.text, token: _tokenController.text);
    if (!mounted) return;
    if (!saved) {
      final message =
          ref.read(profileVmProvider).errorMessage ??
          'No se pudo guardar el perfil.';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
      return;
    }
    context.pushNamed('profile-detail');
  }
}
