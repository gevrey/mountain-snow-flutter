# Mountain Snow (Flutter)

A lightweight Flutter app for **mountain + ski resort snow planning around Geneva**.

## Features
- **Places list**: both **peaks** and **ski resorts** (curated list around Geneva).
- **7‑day forecast** per place (Open‑Meteo):
  - Snowfall (cm/day)
  - Snow depth max (m)
  - Temperature min/max (°C)
- **User‑friendly charts** (via `fl_chart`) + a compact day-by-day list.
- **Quick links**:
  - "Snow report" (opens the resort’s latest conditions page)
  - "Avalanche bulletin" (opens the official bulletin)
    - France: **Météo‑France mountain bulletin**
    - Switzerland: **WhiteRisk**

## Data sources
- Forecast: https://open-meteo.com/ (API: `api.open-meteo.com`)
- Avalanche bulletins:
  - https://meteofrance.com/meteo-montagne/
  - https://whiterisk.ch/
- Resort snow report links are curated (URLs may change).

## Run
```bash
flutter pub get
flutter run
```

## Notes / Roadmap
- Add per-place **region mapping** for avalanche bulletins (better than global links)
- Add **search**, favorites, and offline caching
- Optionally parse avalanche danger level (1–5) and show it in-app (currently links only)

## License
TBD
