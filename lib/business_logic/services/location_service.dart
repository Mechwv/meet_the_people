import 'dart:async';

import 'package:location/location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class LocationService {
  final Location location = Location();
  late StreamSubscription<LocationData> locationSubscription;

  final _pointsController = StreamController<Point>();
  Stream<Point> get points => _pointsController.stream;
  
  void fetchLocation() {
    locationSubscription = location.onLocationChanged
        .listen((LocationData locationData) {
          _pointsController.sink.add(Point(longitude: locationData.longitude!, latitude: locationData.latitude!));
        });
  }

  void close() async {
    _pointsController.close();
    await locationSubscription.cancel();
    location.enableBackgroundMode(enable: false);
  }

  void initLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionStatus;
    location.enableBackgroundMode(enable: true);

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw 'Unable to enable Service';
      }
    }

    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if(permissionStatus != PermissionStatus.granted) {
        throw 'Unable to enable Permission';
      }
    }
  }

  Future<Point> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionStatus;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw 'Unable to enable Service';
      }
    }

    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if(permissionStatus != PermissionStatus.granted) {
        throw 'Unable to enable Permission';
      }
    }

    locationData = await location.getLocation();
    return Point(
        latitude: locationData.latitude!,
        longitude: locationData.longitude!
    );
  }
}