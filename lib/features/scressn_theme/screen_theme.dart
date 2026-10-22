import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screen_theme_provider.dart';

class ScreenTheme extends ConsumerWidget {
  const ScreenTheme({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(screenThemeVmProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Tema de la aplicación')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isDarkMode ? Icons.dark_mode : Icons.light_mode,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text('Tema actual: ${isDarkMode ? 'oscuro' : 'claro'}'),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () =>
                  ref.read(screenThemeVmProvider.notifier).toggleTheme(),
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
              label: Text(isDarkMode ? 'Usar tema claro' : 'Usar tema oscuro'),
            ),
          ],
        ),
      ),
    );
  }
}
