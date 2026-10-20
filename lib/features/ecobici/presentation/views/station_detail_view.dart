import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../vm/station_detail_view_model.dart';
import '../vm/stations_view_model.dart';
import '../widgets/feedback_view.dart';

class StationDetailView extends ConsumerWidget {
  const StationDetailView({super.key, required this.stationId});

  final String stationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final station = ref.watch(stationDetailViewModelProvider(stationId));

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de estación')),
      body: station.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => FeedbackView(
          message: 'No se pudo cargar la estación.',
          onRetry: () => ref.read(stationsViewModelProvider.notifier).refresh(),
        ),
        data: (item) {
          if (item == null) {
            return const FeedbackView(message: 'Estación no encontrada.');
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(item.name, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.location_city_outlined),
                title: const Text('Alcaldía'),
                trailing: Text(item.alcaldia),
              ),
              ListTile(
                leading: const Icon(Icons.route_outlined),
                title: const Text('Línea'),
                trailing: Text(item.lineId),
              ),
              ListTile(
                leading: const Icon(Icons.pin_outlined),
                title: const Text('Número de estación'),
                trailing: Text(item.stationNumber),
              ),
            ],
          );
        },
      ),
    );
  }
}
