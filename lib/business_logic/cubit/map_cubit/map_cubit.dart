import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:meet_the_people/business_logic/cubit/map_cubit/map_state.dart';
import 'package:meet_the_people/business_logic/services/location_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../constants/constant_methods.dart';
import '../../../data/di/di.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit(): super(MapInitial());

  void openSlider(){
    emit(MapObjectChosen());
  }

  void closeSlider() {
    emit(MapInitial());
  }
}