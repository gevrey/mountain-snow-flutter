import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/open_meteo_api.dart';
import '../data/places.dart';
import '../models/place.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _api = OpenMeteoApi();

  PlaceType? _filter; // null = both
  Place _selected = places.first;

  bool _loading = false;
  String? _error;
  List<DailySnow> _forecast = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final res = await _api.fetchSnowForecast7d(lat: _selected.lat, lon: _selected.lon);
      if (!mounted) return;
      setState(() {
        _forecast = res;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _forecast = const [];
      });
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  List<Place> get _filteredPlaces {
    if (_filter == null) return places;
    return places.where((p) => p.type == _filter).toList();
  }

  Future<void> _openSnowReport() async {
    final url = _selected.snowReportUrl;
    if (url == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No snow report link for this place yet.')),
      );
      return;
    }

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to open link.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dayFmt = DateFormat('EEE dd');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mountain Snow'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _loading ? null : _load,
            icon: _loading ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.refresh),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Filter
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ChoiceChip(
                label: const Text('Both'),
                selected: _filter == null,
                onSelected: (_) => setState(() => _filter = null),
              ),
              ChoiceChip(
                label: const Text('Peaks'),
                selected: _filter == PlaceType.peak,
                onSelected: (_) => setState(() {
                  _filter = PlaceType.peak;
                  if (_selected.type != PlaceType.peak) _selected = _filteredPlaces.first;
                  _load();
                }),
              ),
              ChoiceChip(
                label: const Text('Resorts'),
                selected: _filter == PlaceType.resort,
                onSelected: (_) => setState(() {
                  _filter = PlaceType.resort;
                  if (_selected.type != PlaceType.resort) _selected = _filteredPlaces.first;
                  _load();
                }),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Picker
          DropdownButtonFormField<Place>(
            initialValue: _filteredPlaces.contains(_selected) ? _selected : _filteredPlaces.first,
            decoration: const InputDecoration(
              labelText: 'Select a place',
              border: OutlineInputBorder(),
            ),
            items: _filteredPlaces
                .map(
                  (p) => DropdownMenuItem(
                    value: p,
                    child: Text('${p.name}  •  ${p.type == PlaceType.peak ? 'Peak' : 'Resort'}'),
                  ),
                )
                .toList(),
            onChanged: (p) {
              if (p == null) return;
              setState(() => _selected = p);
              _load();
            },
          ),

          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _openSnowReport,
            icon: const Icon(Icons.open_in_new),
            label: const Text('Open latest snow report'),
          ),

          const SizedBox(height: 20),
          Text('7‑day snow forecast', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),

          if (_error != null)
            Card(
              color: theme.colorScheme.errorContainer,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(_error!, style: TextStyle(color: theme.colorScheme.onErrorContainer)),
              ),
            )
          else if (_forecast.isEmpty)
            const Text('No forecast data yet (or provider does not return snow metrics for this location).')
          else
            ..._forecast.map((d) {
              final snow = d.snowfallCm;
              final depth = d.snowDepthMaxM;
              final tmax = d.tempMaxC;
              final tmin = d.tempMinC;

              String fmtNum(double? v, {String unit = ''}) => v == null ? '—' : '${v.toStringAsFixed(1)}$unit';

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 70,
                        child: Text(dayFmt.format(d.date), style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Snowfall: ${fmtNum(snow, unit: ' cm')}', style: theme.textTheme.bodyMedium),
                            const SizedBox(height: 2),
                            Text('Snow depth max: ${fmtNum(depth, unit: ' m')}', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                            const SizedBox(height: 2),
                            Text('Temp: ${fmtNum(tmin, unit: '°C')} → ${fmtNum(tmax, unit: '°C')}', style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

          const SizedBox(height: 12),
          Text(
            'Data: Open‑Meteo (forecast) + curated resort links (snow report).',
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
