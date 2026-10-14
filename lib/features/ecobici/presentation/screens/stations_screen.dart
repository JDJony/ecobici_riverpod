import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/ecobici_providers.dart';

class StationsScreen extends ConsumerWidget {
  const StationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stations = ref.watch(stationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ECOBICI CDMX'),
        actions: [
          IconButton(
            tooltip: 'Actualizar estaciones',
            onPressed: () => ref.invalidate(stationsProvider),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: stations.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: TextButton.icon(
            onPressed: () => ref.invalidate(stationsProvider),
            icon: const Icon(Icons.refresh),
            label: const Text('No se pudieron cargar las estaciones. Reintentar'),
          ),
        ),
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('No hay estaciones disponibles.'));
          }

          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final station = items[index];
              return ListTile(
                leading: const Icon(Icons.pedal_bike),
                title: Text(station.name),
                subtitle: Text(
                  '${station.availableBikes} bicicletas disponibles',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.goNamed(
                  'station-detail',
                  pathParameters: {'stationId': station.id},
                ),
              );
            },
          );
        },
      ),
    );
  }
}