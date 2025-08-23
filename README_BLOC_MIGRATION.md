# Ditonton App - BLoC Migration & SSL Pinning Implementation

## Submission Criteria Implementation

### 1. Migration from Provider to BLoC State Management

#### Overview
This project has been migrated from Provider-based state management to BLoC (Business Logic Component) pattern. BLoC provides better separation of concerns and more predictable state management.

#### Key Changes Made:

##### A. Added Dependencies
```yaml
dependencies:
  flutter_bloc: ^8.1.6
  bloc: ^8.1.4
  rxdart: ^0.27.7  # For debouncing in search functionality
  http_certificate_pinning: ^2.1.1  # For SSL Pinning
```

##### B. Created BLoC Structure
```
lib/presentation/bloc/
├── movies/
│   ├── popular_movies_bloc.dart
│   ├── popular_movies_event.dart
│   ├── popular_movies_state.dart
│   ├── top_rated_movies_bloc.dart
│   ├── top_rated_movies_event.dart
│   ├── top_rated_movies_state.dart
│   ├── now_playing_movies_bloc.dart
│   ├── now_playing_movies_event.dart
│   ├── now_playing_movies_state.dart
│   ├── movie_detail_bloc.dart
│   ├── movie_detail_event.dart
│   ├── movie_detail_state.dart
│   ├── movie_search_bloc.dart
│   ├── movie_search_event.dart
│   ├── movie_search_state.dart
│   ├── watchlist_movie_bloc.dart
│   ├── watchlist_movie_event.dart
│   └── watchlist_movie_state.dart
└── tv_series/
    ├── popular_tv_series_bloc.dart
    ├── popular_tv_series_event.dart
    ├── popular_tv_series_state.dart
    ├── top_rated_tv_series_bloc.dart
    ├── top_rated_tv_series_event.dart
    └── top_rated_tv_series_state.dart
```

##### C. Updated Dependency Injection
The `injection.dart` file has been updated to register BLoCs instead of ChangeNotifiers:

```dart
// Old Provider registration
locator.registerFactory(() => PopularMoviesNotifier(locator()));

// New BLoC registration
locator.registerFactory(() => PopularMoviesBloc(locator()));
```

##### D. Updated Main App
The main app now uses `MultiBlocProvider` instead of `MultiProvider`:

```dart
// Old Provider setup
return MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => di.locator<PopularMoviesNotifier>()),
  ],
  child: MaterialApp(...),
);

// New BLoC setup
return MultiBlocProvider(
  providers: [
    BlocProvider(create: (_) => di.locator<PopularMoviesBloc>()),
  ],
  child: MaterialApp(...),
);
```

##### E. Updated UI Components
UI pages have been updated to use BlocBuilder and BlocConsumer instead of Consumer:

```dart
// Old Provider pattern
Consumer<PopularMoviesNotifier>(
  builder: (context, data, child) {
    if (data.state == RequestState.Loading) {
      return CircularProgressIndicator();
    }
    // ...
  },
)

// New BLoC pattern
BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
  builder: (context, state) {
    if (state is PopularMoviesLoading) {
      return CircularProgressIndicator();
    }
    // ...
  },
)
```

### 2. SSL Pinning Implementation

#### Overview
SSL Pinning has been implemented to provide an additional security layer when accessing data from The Movie Database (TMDB) API.

#### Implementation Details:

##### A. SSL Pinning Helper
Created `lib/common/network/ssl_pinning.dart` with certificate pinning functionality:

```dart
class SSLPinningHelper {
  static Future<bool> certificatePinningCheck() async {
    try {
      // List of allowed SHA256 fingerprints for themoviedb.org
      final List<String> allowedSHAFingerprints = [
        // TMDB certificate SHA256 fingerprint
        '1A:2B:3C:4D:5E:6F:7A:8B:9C:0D:1E:2F:3A:4B:5C:6D:7E:8F:9A:0B:1C:2D:3E:4F:5A:6B:7C:8D:9E:0F:1A:2B',
        // Backup certificate fingerprint
        '2B:3C:4D:5E:6F:7A:8B:9C:0D:1E:2F:3A:4B:5C:6D:7E:8F:9A:0B:1C:2D:3E:4F:5A:6B:7C:8D:9E:0F:1A:2B:3C',
      ];

      await HttpCertificatePinning.check(
        serverURL: "https://api.themoviedb.org",
        headerHttp: {"Content-Type": "application/json"},
        sha: SHA.SHA256,
        allowedSHAFingerprints: allowedSHAFingerprints,
        timeout: 60,
      );

      return true;
    } catch (e) {
      print('Certificate pinning check failed: $e');
      return false;
    }
  }
}
```

##### B. Main App Integration
SSL Pinning is initialized in the main function:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize SSL Pinning
  await SSLPinningHelper.init();
  
  // Initialize dependency injection
  di.init();
  
  runApp(MyApp());
}
```

## Migration Benefits

### 1. BLoC Pattern Advantages:
- **Better Separation of Concerns**: Business logic is separated from UI
- **Testability**: Easier to unit test business logic
- **Predictable State Management**: Clear state transitions
- **Scalability**: Better for large applications
- **Reactive Programming**: Uses streams for reactive state management

### 2. SSL Pinning Advantages:
- **Enhanced Security**: Protection against man-in-the-middle attacks
- **Certificate Validation**: Ensures connection to legitimate TMDB servers
- **Additional Security Layer**: Complements HTTPS encryption

## Testing

### BLoC Testing
Each BLoC can be tested independently:

```dart
test('should emit [Loading, Loaded] when data is fetched successfully', () async {
  // arrange
  when(mockGetPopularMovies.execute())
      .thenAnswer((_) async => Right(tMovieList));

  // act
  bloc.add(FetchPopularMovies());

  // assert
  expectLater(
    bloc.stream,
    emitsInOrder([
      PopularMoviesLoading(),
      PopularMoviesLoaded(tMovieList),
    ]),
  );
});
```

### SSL Pinning Testing
SSL Pinning can be tested by checking certificate validation:

```dart
test('should return true when certificate pinning is successful', () async {
  // act
  final result = await SSLPinningHelper.certificatePinningCheck();

  // assert
  expect(result, true);
});
```

## Next Steps

1. **Complete Migration**: Migrate all remaining Provider-based pages to BLoC
2. **Update Tests**: Update all existing tests to work with BLoC pattern
3. **Get Real Certificates**: Replace placeholder certificate fingerprints with actual TMDB certificates
4. **Error Handling**: Implement comprehensive error handling for SSL failures
5. **Performance Optimization**: Optimize BLoC performance for large datasets

## Files Modified/Created

### New BLoC Files:
- `lib/presentation/bloc/movies/*` - All movie-related BLoCs
- `lib/presentation/bloc/tv_series/*` - All TV series-related BLoCs

### SSL Pinning Files:
- `lib/common/network/ssl_pinning.dart` - SSL pinning implementation

### Updated Files:
- `pubspec.yaml` - Added new dependencies
- `lib/main.dart` - Updated to use BLoC and SSL pinning
- `lib/injection.dart` - Updated dependency injection
- `lib/presentation/pages/popular_movies_bloc_page.dart` - Example BLoC page

### Configuration Files:
- `README_BLOC_MIGRATION.md` - This documentation file

## Important Notes

1. **Certificate Fingerprints**: The SSL certificate fingerprints in this implementation are placeholders. In production, you must obtain the actual SHA256 fingerprints of TMDB's SSL certificates.

2. **Gradual Migration**: This implementation shows both Provider and BLoC patterns coexisting. In a complete migration, all Provider-based code should be removed.

3. **Testing**: Comprehensive testing should be implemented for all BLoCs and SSL pinning functionality.

4. **Error Handling**: Proper error handling should be implemented for SSL pinning failures and BLoC error states.
