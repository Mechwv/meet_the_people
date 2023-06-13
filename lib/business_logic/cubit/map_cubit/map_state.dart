import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

@immutable
abstract class MapState {}

class MapInitial extends MapState {}

class MapObjectChosen extends MapState {}

class MapPathBuilt extends MapState {}

class MapPathFinished extends MapState {}
