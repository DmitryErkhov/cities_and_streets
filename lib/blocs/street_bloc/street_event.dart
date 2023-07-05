part of 'street_bloc.dart';

@immutable
abstract class StreetEvent {}

class FetchStreetEvent extends StreetEvent {

  final int? cityId;

  FetchStreetEvent(this.cityId);
}
