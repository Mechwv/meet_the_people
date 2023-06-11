import 'package:flutter/material.dart';

@immutable
abstract class MapState {}

class MapInitial extends MapState {}

class GetFilterHotelsLoadingState extends MapState {}

class GetFilterHotelsFailureState extends MapState {
  final String? errorMessage;

  GetFilterHotelsFailureState([this.errorMessage]);
}

class GetFacilitiesSuccessState extends MapState {}

class GetFacilitiesLoadingState extends MapState {}

class GetFacilitiesFailureState extends MapState {
  final String? errorMessage;

  GetFacilitiesFailureState([this.errorMessage]);
}

class PickNewLocationState extends MapState {}