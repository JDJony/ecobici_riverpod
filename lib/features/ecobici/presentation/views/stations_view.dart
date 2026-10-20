import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../vm/stations_view_model.dart';
import '../widgets/feedback_view.dart';
import '../widgets/station_tile.dart';

class StationsView extends ConsumerWidget {
  const StationsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stations = ref.watch(stationsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estaciones del Metro'),
        actions: [
          IconButton(
            tooltip: 'Actualizar estaciones',
            onPressed: () =>
                ref.read(stationsViewModelProvider.notifier).refresh(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: stations.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => FeedbackView(
          message: 'No se pudieron cargar las estaciones.',
          onRetry: () => ref.read(stationsViewModelProvider.notifier).refresh(),
        ),
        data: (items) {
          if (items.isEmpty) {
            return const FeedbackView(
              message: 'No hay estaciones disponibles.',
            );
          }

          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final station = items[index];
              return StationTile(
                station: station,
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
