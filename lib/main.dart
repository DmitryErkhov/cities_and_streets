import 'package:cities_and_streets/blocs/bloc_export.dart';
import 'package:cities_and_streets/screen/home_screen.dart';
import 'package:cities_and_streets/screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CityBloc()),
        BlocProvider(create: (context) => StreetBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: 'Inter',
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        routes: {
          '/home' : (context) => const HomeScreen(),
        },
      ),
    );
  }
}