import 'dart:convert';

import 'package:http/http.dart' as http;

class DailySnow {
  final DateTime date;
  final double? snowfallCm;
  final double? snowDepthMaxM;
  final double? tempMaxC;
  final double? tempMinC;

  DailySnow({
    required this.date,
    required this.snowfallCm,
    required this.snowDepthMaxM,
    required this.tempMaxC,
    required this.tempMinC,
  });
}

class OpenMeteoApi {
  Future<List<DailySnow>> fetchSnowForecast7d({required double lat, required double lon}) async {
    final uri = Uri.parse('https://api.open-meteo.com/v1/forecast').replace(queryParameters: {
      'latitude': '$lat',
      'longitude': '$lon',
      'timezone': 'auto',
      // snow-focused daily metrics (availability varies by model/location)
      'daily': 'snowfall_sum,snow_depth_max,temperature_2m_max,temperature_2m_min',
      'forecast_days': '7',
    });

    final resp = await http.get(uri);
    if (resp.statusCode != 200) {
      throw Exception('Open-Meteo error HTTP ${resp.statusCode}');
    }

    final j = json.decode(resp.body) as Map<String, dynamic>;
    final daily = (j['daily'] as Map?)?.cast<String, dynamic>();
    if (daily == null) return [];

    final times = (daily['time'] as List?)?.cast<dynamic>() ?? const [];
    final snowfall = (daily['snowfall_sum'] as List?)?.cast<dynamic>();
    final depth = (daily['snow_depth_max'] as List?)?.cast<dynamic>();
    final tmax = (daily['temperature_2m_max'] as List?)?.cast<dynamic>();
    final tmin = (daily['temperature_2m_min'] as List?)?.cast<dynamic>();

    double? numAt(List<dynamic>? arr, int i) {
      if (arr == null) return null;
      if (i < 0 || i >= arr.length) return null;
      final v = arr[i];
      if (v == null) return null;
      if (v is num) return v.toDouble();
      return double.tryParse(v.toString());
    }

    final out = <DailySnow>[];
    for (var i = 0; i < times.length; i++) {
      final dt = DateTime.tryParse(times[i].toString());
      if (dt == null) continue;
      out.add(DailySnow(
        date: dt,
        snowfallCm: numAt(snowfall, i),
        snowDepthMaxM: numAt(depth, i),
        tempMaxC: numAt(tmax, i),
        tempMinC: numAt(tmin, i),
      ));
    }
    return out;
  }
}
