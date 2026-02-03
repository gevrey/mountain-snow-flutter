import '../models/place.dart';

/// v0 curated list around Geneva.
///
/// Notes:
/// - Coordinates are approximate and can be refined.
/// - Snow report URLs are best-effort and may change.
final places = <Place>[
  // Peaks
  Place(id: 'mont-blanc', name: 'Mont Blanc', type: PlaceType.peak, lat: 45.8326, lon: 6.8652, avalancheReportUrl: Uri.parse('https://www.meteofrance.com/meteo-montagne/alpes-du-nord/haute-savoie/bulletin-avalanches')),
  Place(id: 'aiguille-du-midi', name: 'Aiguille du Midi', type: PlaceType.peak, lat: 45.8799, lon: 6.8871, avalancheReportUrl: Uri.parse('https://www.meteofrance.com/meteo-montagne/alpes-du-nord/haute-savoie/bulletin-avalanches')),
  Place(id: 'dents-du-midi', name: 'Dents du Midi', type: PlaceType.peak, lat: 46.1679, lon: 6.8420, avalancheReportUrl: Uri.parse('https://whiterisk.ch/en/avalanche-bulletin')),
  const Place(id: 'le-saleve', name: 'Le Salève', type: PlaceType.peak, lat: 46.1167, lon: 6.1833),

  // Resorts
  Place(
    id: 'chamonix',
    name: 'Chamonix',
    type: PlaceType.resort,
    lat: 45.9237,
    lon: 6.8694,
    snowReportUrl: Uri.parse('https://www.chamonix.com/en/conditions'),
    avalancheReportUrl: Uri.parse('https://www.meteofrance.com/meteo-montagne/alpes-du-nord/haute-savoie/bulletin-avalanches'),
  ),
  Place(
    id: 'les-houches',
    name: 'Les Houches',
    type: PlaceType.resort,
    lat: 45.8905,
    lon: 6.7952,
    snowReportUrl: Uri.parse('https://www.leshouches.com/en/winter/ski-area/snow-report'),
    avalancheReportUrl: Uri.parse('https://www.meteofrance.com/meteo-montagne/alpes-du-nord/haute-savoie/bulletin-avalanches'),
  ),
  Place(
    id: 'megeve',
    name: 'Megève',
    type: PlaceType.resort,
    lat: 45.8568,
    lon: 6.6180,
    snowReportUrl: Uri.parse('https://www.megeve.com/en/infos-live/webcams-weather-snow/'),
    avalancheReportUrl: Uri.parse('https://www.meteofrance.com/meteo-montagne/alpes-du-nord/haute-savoie/bulletin-avalanches'),
  ),
  Place(
    id: 'la-clusaz',
    name: 'La Clusaz',
    type: PlaceType.resort,
    lat: 45.9059,
    lon: 6.4246,
    snowReportUrl: Uri.parse('https://www.laclusaz.com/en/live/snow-report/'),
    avalancheReportUrl: Uri.parse('https://www.meteofrance.com/meteo-montagne/alpes-du-nord/haute-savoie/bulletin-avalanches'),
  ),
  Place(
    id: 'avoriaz',
    name: 'Avoriaz',
    type: PlaceType.resort,
    lat: 46.1926,
    lon: 6.7753,
    snowReportUrl: Uri.parse('https://en.avoriaz.com/ski-area/snow-report/'),
    avalancheReportUrl: Uri.parse('https://www.meteofrance.com/meteo-montagne/alpes-du-nord/haute-savoie/bulletin-avalanches'),
  ),
  Place(
    id: 'morzine',
    name: 'Morzine',
    type: PlaceType.resort,
    lat: 46.1800,
    lon: 6.7050,
    snowReportUrl: Uri.parse('https://www.morzine-avoriaz.com/en/ski/snow-report'),
    avalancheReportUrl: Uri.parse('https://www.meteofrance.com/meteo-montagne/alpes-du-nord/haute-savoie/bulletin-avalanches'),
  ),
  Place(
    id: 'verbier',
    name: 'Verbier (4 Vallées)',
    type: PlaceType.resort,
    lat: 46.0961,
    lon: 7.2286,
    snowReportUrl: Uri.parse('https://www.verbier4vallees.ch/en/live/webcams-weather-snow'),
    avalancheReportUrl: Uri.parse('https://whiterisk.ch/en/avalanche-bulletin'),
  ),
];
