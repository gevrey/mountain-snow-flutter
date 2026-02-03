enum PlaceType { peak, resort }

class Place {
  final String id;
  final String name;
  final PlaceType type;

  /// For forecast.
  final double lat;
  final double lon;

  /// Optional “latest snow report” link (often resorts).
  final Uri? snowReportUrl;

  const Place({
    required this.id,
    required this.name,
    required this.type,
    required this.lat,
    required this.lon,
    this.snowReportUrl,
  });
}
