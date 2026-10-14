import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/ecobici_providers.dart';

class StationDetailScreen extends ConsumerWidget {
  const StationDetailScreen({super.key, required this.stationId});

  final String stationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final station = ref.watch(stationDetailProvider(stationId));

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de estacion')),
      body: station.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: TextButton.icon(
            onPressed: () => ref.invalidate(stationsProvider),
            icon: const Icon(Icons.refresh),
            label: const Text('No se pudo cargar la estacion. Reintentar'),
          ),
        ),
        data: (item) {
          if (item == null) {
            return const Center(child: Text('Estacion no encontrada.'));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(item.name, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.pedal_bike),
                title: const Text('Bicicletas disponibles'),
                trailing: Text('${item.availableBikes}'),
              ),
              ListTile(
                leading: const Icon(Icons.local_parking),
                title: const Text('Espacios disponibles'),
                trailing: Text('${item.availableDocks}'),
              ),
              ListTile(
                leading: const Icon(Icons.location_on_outlined),
                title: const Text('Coordenadas'),
                subtitle: Text('${item.latitude}, ${item.longitude}'),
              ),
            ],
          );
        },
      ),
    );
  }
}