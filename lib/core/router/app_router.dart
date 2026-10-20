import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/ecobici/presentation/views/station_detail_view.dart';
import '../../features/ecobici/presentation/views/stations_view.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'stations',
        builder: (context, state) => const StationsView(),
        routes: [
          GoRoute(
            path: 'stations/:stationId',
            name: 'station-detail',
            builder: (context, state) => StationDetailView(
              stationId: state.pathParameters['stationId']!,
            ),
          ),
        ],
      ),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
});
