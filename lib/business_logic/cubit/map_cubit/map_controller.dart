import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meet_the_people/business_logic/cubit/global_cubit/global_cubit.dart';
import 'package:meet_the_people/business_logic/cubit/people_cubit/people_cubit.dart';
import 'package:meet_the_people/business_logic/services/location_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../constants/constant_methods.dart';
import '../../../data/di/di.dart';
import '../../../data/repository/people_repository.dart';

class MapController with ChangeNotifier {
  final List<MapObject> _objectsList = [];
  late YandexMapController? _controller;
  static const MapObjectId _posId = MapObjectId('positionMark');
  static const MapObjectId _radId = MapObjectId('searchRadius');
  static const double _fixedZoom = 13.5;
  static const double _fixedRadius = 1500;
  static const animation =
      MapAnimation(type: MapAnimationType.smooth, duration: 1.0);
  final List<Point> points = [];
  final _fixedOpacity = 0.95;
  final timerController = TimerController();

   List<Point> people = [
    Point(latitude: 55.63250623928817, longitude: 37.41819001867677),
    Point(latitude: 55.626336887387964,longitude:  37.41919146329349),
    Point(latitude: 55.62370843001374, longitude: 37.42099970440077),
    Point(latitude: 55.62318901952856, longitude: 37.42166034441598),
    Point(latitude: 55.62306703576079, longitude: 37.42300944086804),
  ];

  get mapObjects => _objectsList;

  Future<void> onMapCreated(YandexMapController controller) async {
    _controller = controller;
    _getPosition();
    _fetchPosition();
    Future.delayed(const Duration(seconds: 2), () {
      timerController.start();
    });
  }

  void _fetchPosition() {
    print("_FETCH_POS");
    final locService = sl<LocationService>();
    locService.initLocation();
    locService.fetchLocation();
    locService.points.listen((event) async {
      points.add(event);
      // _moveCamera(event.latitude, event.longitude);
      _updateMapObjects();
    });
    print("_END_FETCH_POS");
  }

  void moveCameraOnUser() {
    _moveCamera(lat: points.last.latitude, long: points.last.longitude);
  }

  void _moveCamera({required double lat, required double long}) {
    _controller?.moveCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
            target: Point(latitude: lat, longitude: long), zoom: _fixedZoom)),
        animation: animation);
  }

  void _getPosition() {
    sl<LocationService>().getCurrentLocation().then((value) async {
      points.add(value);
      _initPositionMark();
      _initPositionRadius();
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
      opacity: _fixedOpacity,
      icon: await _createAvatar(
        'https://i1.sndcdn.com/avatars-000290781095-i22idu-t240x240.jpg',
      ),
      onTap: (PlacemarkMapObject self, Point point) =>
          print('Tapped me at $point'),
    );
    _objectsList.add(placemark);
    print("_END_INIT_POS");
  }

  void _initPositionRadius() async {
    if (_objectsList.any((el) => el.mapId == _radId)) {
      return;
    }
    _objectsList.add(createSearchRadius());
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

  void _updatePositionRadius() async {
    if (!_objectsList.any((el) => el.mapId == _radId)) {
      return;
    }
    final placemark =
        _objectsList.firstWhere((el) => el.mapId == _radId) as CircleMapObject;
    _objectsList[_objectsList.indexOf(placemark)] = placemark.copyWith(
        circle: Circle(
            center: Point(
                latitude: points.last.latitude,
                longitude: points.last.longitude),
            radius: _fixedRadius));
  }

  void _populateMap() async {
    final list = List<Future<PlacemarkMapObject>>.generate(5, (i) async {
      return PlacemarkMapObject(
          opacity: _fixedOpacity,
          mapId: MapObjectId(sl<GlobalCubit>().uuids[i]),
          point: people[i],
        icon: await _createAvatar(sl<PeopleCubit>().peopleNear[i].avatar)
      );
    });
    final res = await Future.wait(list);
    // res.forEach((element) {
    //   print(element.mapId);
    // });
    _objectsList.addAll(res);
  }

  void _movePeople() {
    print("MOVING FOR TIME ${timerController.getLastTime}");
    people[0] = timerController.getLomonosov;
    people[1] = timerController.getTesla;
  }

  Future<Uint8List> _rawPositionPlacemark() async {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);
    final size = Size(50, 50);
    final fillPaint = Paint()
      ..color = Colors.blue[800]!
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
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

  Future<PlacemarkIcon> _createAvatar(String link) async {
    return PlacemarkIcon.single(PlacemarkIconStyle(
      image: await downloadResizePictureCircle(link,
          size: 110,
          addBorder: true,
          borderColor: Colors.white,
          borderSize: 10),
    ));
  }

  CircleMapObject createSearchRadius() {
    final placemark = CircleMapObject(
      mapId: _radId,
      circle: Circle(
          center: Point(latitude: 55.781863, longitude: 37.451159),
          radius: _fixedRadius),
      strokeColor: Colors.blue[700]!,
      strokeWidth: 0,
      fillColor: Color.fromRGBO(0, 111, 253, 0.17),
      onTap: (CircleMapObject self, Point point) =>
          print('Tapped circle at $point'),
    );
    return placemark;
  }

  void _updateMapObjects() async {
    _updatePositionMark();
    _updatePositionRadius();
    _populateMap();
    notifyListeners();
    if (timerController.getLastTime < 11) {
      _movePeople();
    }
  }
}

class TimerController {
  late Timer _timer;

  final _controller = StreamController<int>();
  final _teslaController = BehaviorSubject<Point>();
  final _lomonosovController = BehaviorSubject<Point>();

  Stream<int> get getTime => _controller.stream;

  Point get getTesla => _teslaController.value;
  Point get getLomonosov => _lomonosovController.value;

  int get getLastTime => _timer.tick;

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      _controller.sink.add(timer.tick);
      _teslaController.sink.add(sl<PeopleCubit>().teslaMovement[timer.tick]);
      _lomonosovController.sink.add(sl<PeopleCubit>().lomonosovMovement[timer.tick]);
    });
  }

  void dispose() {
    _timer.cancel();
    _controller.close();
  }
}
