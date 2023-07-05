import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cities_and_streets/models/street.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'street_event.dart';

part 'street_state.dart';

class StreetBloc extends Bloc<StreetEvent, StreetState> {
  StreetBloc() : super(StreetLoadingState()) {
    on<FetchStreetEvent>((event, emit) => _fetchStreetData(event.cityId));
  }

  Future<void> _fetchStreetData(int? cityId) async {
    emit(StreetLoadingState());
    try {
      var response = await http.get(Uri.parse(
          'https://649befbd0480757192372825.mockapi.io/api/v1/cities/$cityId/streets'));
      if (response.statusCode == 200) {
        final List<Street> streets = [];
        final List<dynamic> data = json.decode(response.body);
        for (var item in data) {
          streets.add(Street(name: item['name'].toString(), address: item['address'].toString()));
        }
        emit(StreetLoadedState(streets));
      } else {
        emit(StreetErrorState());
      }
    } catch (e) {
      emit(StreetErrorState());
    }
  }
}
