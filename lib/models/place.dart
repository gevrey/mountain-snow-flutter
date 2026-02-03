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

  /// Optional avalanche bulletin link.
  /// We’ll open externally; parsing bulletins can be added later.
  final Uri? avalancheReportUrl;

  const Place({
    required this.id,
    required this.name,
    required this.type,
    required this.lat,
    required this.lon,
    this.snowReportUrl,
    this.avalancheReportUrl,
  });
}
