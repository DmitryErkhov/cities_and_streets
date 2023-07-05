import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cities_and_streets/models/city.dart';
import 'package:cities_and_streets/service/date_parse.dart';
import 'package:http/http.dart' as http;

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  CityBloc() : super(CityLoadingState()) {
    on<FetchCityEvent>((event, emit) => _fetchCityData());
  }

  Future<void> _fetchCityData() async {
    emit(CityLoadingState());
    try {
      var response = await http.get(Uri.parse('https://649befbd0480757192372825.mockapi.io/api/v1/cities'));
      if (response.statusCode == 200) {
        final List<City> cities = [];
        final List<dynamic> data = json.decode(response.body);
        for (var item in data) {
          cities.add(
              City(
                id: int.parse(item['id'].toString()),
                name: item['name'],
                image: item['image'],
                dateTimeImage: dateParse(item['dateTimeImage']),
                totalPeople: item['totalPeople'],
                lat: double.parse(item['lat'].toString()),
                long: double.parse(item['long'].toString()),
              )
          );
        }
        emit(CityLoadedState(cities));
      } else {
        emit(CityErrorState());
      }
    } catch (e) {
      emit(CityErrorState());
    }
  }
}