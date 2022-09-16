import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_bloc_example/weather/weather.dart';
import 'package:weather_repository/weather_repository.dart' hide Weather;

class ThemeCubit extends Cubit<Color>{
  static const defaultColor = Color(0xFF2196F3);

  ThemeCubit() : super(defaultColor);

  void updateTheme(Weather? weather){
    if(weather != null) emit(weather.toColor);
  }

  Color fromJson(Map<String, dynamic> json){
    return Color(int.parse(json['color'] as String));
  }

  Map<String, dynamic> toJson (Color state){
    return <String, String> {'color': '${state.value}'};
  }
}

extension on Weather {
  Color get toColor {
    switch (condition) {
      case WeatherCondition.clear:
        return Colors.orangeAccent;
      case WeatherCondition.snowy:
        return Colors.lightBlueAccent;
      case WeatherCondition.cloudy:
        return Colors.blueGrey;
      case WeatherCondition.rainy:
        return Colors.indigoAccent;
      case WeatherCondition.unknown:
        return ThemeCubit.defaultColor;
    }
  }
}