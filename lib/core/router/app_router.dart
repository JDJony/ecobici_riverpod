import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/ecobici/presentation/screens/station_detail_screen.dart';
import '../../features/ecobici/presentation/screens/stations_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'stations',
        builder: (context, state) => const StationsScreen(),
        routes: [
          GoRoute(
            path: 'stations/:stationId',
            name: 'station-detail',
            builder: (context, state) => StationDetailScreen(
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