part of 'street_bloc.dart';

abstract class StreetState {}

class StreetLoadingState extends StreetState {}

class StreetErrorState extends StreetState {}

class StreetLoadedState extends StreetState {

  final List<Street> streets;

  StreetLoadedState(this.streets);
}
