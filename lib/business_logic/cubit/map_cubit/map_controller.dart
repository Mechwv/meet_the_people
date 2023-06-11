import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meet_the_people/business_logic/services/location_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../data/di/di.dart';

class MapController with ChangeNotifier {
  final List<MapObject> _objectsList = [];
  late YandexMapController? _controller;
  static const MapObjectId _posId = MapObjectId('positionMark');
  static const double _fixedZoom = 12.5;
  static const animation =
  MapAnimation(type: MapAnimationType.smooth, duration: 1.0);
  final List<Point> points = [];

  get mapObjects => _objectsList;

  Future<void> onMapCreated(YandexMapController controller) async {
    _controller = controller;
    _getPosition();
    _fetchPosition();
  }

  void _fetchPosition() {
    print("_FETCH_POS");
    final locService = sl<LocationService>();
    locService.initLocation();
    locService.fetchLocation();
    locService.points.listen((event) async {
      points.add(event);
      _moveCamera(event.latitude, event.longitude);
      _updatePositionMark();
      _updateMapObjects();
    });
    print("_END_FETCH_POS");
  }

  void _moveCamera(double lat, double long) {
    _controller?.moveCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
            target: Point(latitude: lat, longitude: long), zoom: _fixedZoom)),
        animation: animation);
  }

  void _getPosition() {
    sl<LocationService>().getCurrentLocation().then((value) async {
      points.add(value);
      _initPositionMark();
    });
  }

  void _initPositionMark() async {
    print("_INIT_POS");
    if (_objectsList.any((el) => el.mapId == _posId)) {
      return;
    }
    final placemark = PlacemarkMapObject(
      mapId: _posId,
      point: points.last,
      opacity: 0.75,
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromBytes(await _rawPositionPlacemark()))),
    );
    _objectsList.add(placemark);
    print("_END_INIT_POS");
  }

  void _updatePositionMark() async {
    if (!_objectsList.any((el) => el.mapId == _posId)) {
      return;
    }
    final placemark = _objectsList.firstWhere((el) => el.mapId == _posId)
    as PlacemarkMapObject;
    _objectsList[_objectsList.indexOf(placemark)] = placemark.copyWith(
      point: points.last,
    );
  }

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
    final image = await recorder
        .endRecording()
        .toImage(size.width.toInt(), size.height.toInt());
    final pngBytes = await image.toByteData(format: ImageByteFormat.png);
    return pngBytes!.buffer.asUint8List();
  }

  Future<PlacemarkMapObject> createUserMark() async {
    final placemark = PlacemarkMapObject(
      mapId: _posId,
      point: points.last,
      opacity: 0.75,
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromBytes(await _rawPositionPlacemark()))),
    );
    print("_USER_MARK");
    return placemark;
  }

  void _updateMapObjects() async {
    _updatePositionMark();
    notifyListeners();
  }

}
