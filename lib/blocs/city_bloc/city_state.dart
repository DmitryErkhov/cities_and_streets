part of 'city_bloc.dart';

abstract class CityState {}

class CityLoadingState extends CityState {}

class CityErrorState extends CityState {}

class CityLoadedState extends CityState {
  final List<City> cities;

  CityLoadedState(this.cities);
}
