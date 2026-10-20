import 'package:flutter/material.dart';

import '../../domain/entities/station.dart';

class StationTile extends StatelessWidget {
  const StationTile({super.key, required this.station, required this.onTap});

  final Station station;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.subway_outlined),
      title: Text(station.name),
      subtitle: Text(station.alcaldia),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
