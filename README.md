# Newsroom

A polished Flutter news reader powered by [NewsAPI](https://newsapi.org/), with search, topic discovery, infinite scrolling, and locally persisted favorites.

## Features

- Editorial news feed with responsive cards and a featured story
- Search and curated topic filters
- Infinite scrolling and pull-to-refresh
- Local favorites that survive app restarts
- Explicit loading, empty, and failure states
- External article opening

## Architecture

The project uses feature-first Clean Architecture:

```text
lib/
├── core/
│   ├── dependency_injection/
│   ├── domain/
│   ├── errors/
│   └── result/
└── features/
    ├── favorites/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    ├── home/
    │   └── presentation/
    └── news/
        ├── data/
        ├── domain/
        └── presentation/
```

Dependencies flow from presentation to domain interfaces and then to data implementations. Cubits receive use cases through constructor injection, repositories depend on datasource interfaces, and DTOs are mapped before reaching the UI.

## Setup

1. Install the current stable Flutter SDK.
2. Create a free NewsAPI key at <https://newsapi.org/register>.
3. Install dependencies and generate code:

```bash
flutter pub get
dart run build_runner build
```

4. Run the app without storing the key in source control:

```bash
flutter run --dart-define=NEWS_API_KEY=your_api_key
```

## Validation

```bash
flutter analyze
flutter test
flutter build apk --debug --dart-define=NEWS_API_KEY=your_api_key
```

## Security

The NewsAPI key is supplied at build time with `--dart-define` and is not committed. For a production application, requests should be proxied through a backend so provider credentials are never distributed in the client binary.

## License

MIT
