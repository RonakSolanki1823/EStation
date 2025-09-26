# testing

This Flutter app uses Supabase and Google Maps.

## Configure a Supabase account

Provide your Supabase project URL and anon key at runtime using `--dart-define`.

Create `lib/config/api_keys.dart` (already present) which reads:

```dart
class ApiKeys {
  static const String supabaseUrl =
      String.fromEnvironment('SUPABASE_URL', defaultValue: '');
  static const String supabaseAnonKey =
      String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: '');
}
```

## Run commands

Replace placeholders with your Supabase values.

### Web
```bash
flutter clean && flutter pub get
flutter run -d chrome \
  --web-renderer=canvaskit \
  --dart-define=SUPABASE_URL=https://YOUR-PROJECT.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=YOUR_ANON_KEY
```

### Android
Create `android/app/google_api.properties` with:

```properties
GOOGLE_API_KEY=YOUR_ANDROID_GOOGLE_MAPS_KEY
```

Run:

```bash
flutter clean && flutter pub get
flutter run -d android \
  --dart-define=SUPABASE_URL=https://YOUR-PROJECT.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=YOUR_ANON_KEY
```

### iOS
Add location usage descriptions to `ios/Runner/Info.plist` if needed, then run from Xcode or:

```bash
flutter clean && flutter pub get
flutter run -d ios \
  --dart-define=SUPABASE_URL=https://YOUR-PROJECT.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=YOUR_ANON_KEY
```

## Notes
- Android and Web use different Google Maps keys. Web key is referenced in `web/index.html`.
- Keys are ignored by git via `.gitignore`.
