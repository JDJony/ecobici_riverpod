class Station {
  const Station({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.availableBikes,
    required this.availableDocks,
  });

  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final int availableBikes;
  final int availableDocks;
}