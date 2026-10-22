import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'profile_provider.dart';
import 'profile_view_model.dart';

class ProfileDetailView extends ConsumerWidget {
  const ProfileDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileVmProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del perfil')),
      body: switch (profile.status) {
        ProfileStatus.loading || ProfileStatus.saving => const Center(
          child: CircularProgressIndicator(),
        ),
        ProfileStatus.error => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  profile.errorMessage ?? 'No se pudo leer el perfil.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: () => ref.read(profileVmProvider.notifier).load(),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
        ProfileStatus.ready => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ListTile(
              leading: const Icon(Icons.inventory_2_outlined),
              title: Text(profile.name.isEmpty ? 'Sin nombre' : profile.name),
              subtitle: const Text('Nombre guardado en Hive'),
            ),
            ListTile(
              leading: const Icon(Icons.lock_outline),
              title: const Text('Token secreto'),
              subtitle: const Text('Leído desde flutter_secure_storage'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: profile.token.isEmpty
                  ? Text(
                      'Sin token',
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  : _SecretToken(token: profile.token),
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                  return;
                }
                context.goNamed('profile');
              },
              child: const Text('Editar'),
            ),
          ],
        ),
      },
    );
  }
}

class _SecretToken extends StatefulWidget {
  const _SecretToken({required this.token});

  final String token;

  @override
  State<_SecretToken> createState() => _SecretTokenState();
}

class _SecretTokenState extends State<_SecretToken> {
  var _visible = false;

  @override
  Widget build(BuildContext context) {
    final hiddenLength = widget.token.length.clamp(8, 24).toInt();
    return Row(
      children: [
        Expanded(
          child: Text(
            _visible ? widget.token : '•' * hiddenLength,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        IconButton(
          tooltip: _visible ? 'Ocultar token' : 'Mostrar token',
          onPressed: () => setState(() => _visible = !_visible),
          icon: Icon(_visible ? Icons.visibility_off : Icons.visibility),
        ),
      ],
    );
  }
}
