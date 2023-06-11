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

  final List<MapObject> _objectsList = [];
  late YandexMapController? _controller;
  static const MapObjectId _posId = MapObjectId('positionMark');
  static const double _fixedZoom = 17.0;
  static const animation = MapAnimation(type: MapAnimationType.smooth, duration: 1.0);
  final List<Point> points = [];


  Future<Uint8List> _rawPositionPlacemark() async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    final size = Size(40, 40);
    final fillPaint = Paint()
      ..color = Colors.blue[300]!
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    final radius = 20.0;
    final circleOffset = Offset(size.height / 2, size.width / 2);
    canvas.drawCircle(circleOffset, radius, fillPaint);
    canvas.drawCircle(circleOffset, radius, strokePaint);
    final image = await recorder.endRecording().toImage(size.width.toInt(), size.height.toInt());
    final pngBytes = await image.toByteData(format: ImageByteFormat.png);
    return pngBytes!.buffer.asUint8List();
  }

  void _initPositionMark() async {
    if (_objectsList.any((el) => el.mapId == _posId)) {
      return;
    }
    final placemark = PlacemarkMapObject(
      mapId: _posId,
      point: points.last,
      opacity: 0.75,
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromBytes(await _rawPositionPlacemark())
      )),
    );
    _objectsList.add(placemark);
  }

  Future<void> onMapCreated(YandexMapController controller) async {
    _controller = controller;
    _getPosition();
    _fetchPosition();
  }

  void _getPosition() {
    sl<LocationService>().getCurrentLocation().then((value) async {
      points.add(value);
      _initPositionMark();
    });
  }

  void _updatePositionMark() async {
    if (!_objectsList.any((el) => el.mapId == _posId)) {
      return;
    }
    final placemark = _objectsList.firstWhere((el) => el.mapId == _posId) as PlacemarkMapObject;
    _objectsList[_objectsList.indexOf(placemark)] = placemark.copyWith(
      point: points.last,
    );
  }

  void _fetchPosition() {
    final locService = sl<LocationService>();
    locService.initLocation();
    locService.fetchLocation();
    locService.points.listen((event) async {
      points.add(event);
      _moveCamera(event.latitude, event.longitude);
      _updatePositionMark();
    });
  }

  void _moveCamera(double lat, double long) {
    _controller?.moveCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
            target: Point(
                latitude: lat,
                longitude: long),
            zoom: _fixedZoom)),
        animation: animation);
  }
}