import 'package:dio/dio.dart';
import 'package:open_meteo_api/open_meteo_api.dart';

/// Exception thrown when locationSearch fails.
class LocationRequestFailure implements Exception {}

/// Exception thrown when the provided location is not found.
class LocationNotFoundFailure implements Exception {}

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {}

/// Exception thrown when weather for provided location is not found.
class WeatherNotFoundFailure implements Exception {}

class OpenMeteoApiClient {
  final _baseUrlGeocoding = 'https://geocoding-api.open-meteo.com/';
  final _baseUrlWeather = 'https://api.open-meteo.com/';

  Future<Location> locationSearch(String query) async {
    final queryParameters = {'name': query, 'count': '1'};

    final locationResponse = await Dio(BaseOptions(baseUrl: _baseUrlGeocoding))
        .get<Map<String, dynamic>>(
      '/v1/search',
      queryParameters: queryParameters,
    );

    if (locationResponse.statusCode != 200 || locationResponse.data == null) {
      throw LocationRequestFailure();
    }

    final locationJson = locationResponse.data!;

    if (!locationJson.containsKey('results')) {
      throw LocationNotFoundFailure();
    }

    final results = locationJson['results'] as List;

    if (results.isEmpty) {
      throw LocationNotFoundFailure();
    }

    return Location.fromJson(results.first as Map<String, dynamic>);
  }

  Future<Weather> getWeather({
    required double longitude,
    required double latitude,
  }) async {
    final queryParameters = {
      'latitude': '$latitude',
      'longitude': '$longitude',
      'current_weather': 'true'
    };

    final weatherResponse = await Dio(BaseOptions(baseUrl: _baseUrlWeather))
        .get<Map<String, dynamic>>(
      'v1/forecast',
      queryParameters: queryParameters,
    );

    if (weatherResponse.statusCode != 200) {
      throw WeatherRequestFailure();
    }

    final weatherBodyJson = weatherResponse.data!;

    if (!weatherBodyJson.containsKey('current_weather')) {
      throw WeatherNotFoundFailure();
    }

    final weatherJson =
        weatherBodyJson['current_weather'] as Map<String, dynamic>;

    return Weather.fromJson(weatherJson);
  }
}
