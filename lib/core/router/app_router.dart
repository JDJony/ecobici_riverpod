import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/ecobici/presentation/views/station_detail_view.dart';
import '../../features/ecobici/presentation/views/stations_view.dart';
import '../../features/profile/profile_detail_view.dart';
import '../../features/profile/profile_form_view.dart';
import '../../features/scressn_theme/screen_theme.dart';

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
      GoRoute(
        path: '/theme',
        name: 'theme',
        builder: (context, state) => const ScreenTheme(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileFormView(),
        routes: [
          GoRoute(
            path: 'detail',
            name: 'profile-detail',
            builder: (context, state) => const ProfileDetailView(),
          ),
        ],
      ),
    ],
  );

  ref.onDispose(router.dispose);
  return router;
});
