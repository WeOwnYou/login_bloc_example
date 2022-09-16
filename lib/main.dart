import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:login_bloc_example/app.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  runApp(
    MyApp(
      authenticationRepository: AuthenticationRepository(),
      userRepository: UserRepository(),
    ),
  );
  // WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = WeatherBlocObserver();
  // runApp(WeatherApp(weatherRepository: WeatherRepository()));
}
