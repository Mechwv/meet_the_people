import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class DefaultMap extends StatelessWidget {
  final CameraPosition initialCameraPosition;
  // final void Function(ArgumentCallback<Point>?)? onTap;
  final List<MapObject> markers;
  final void Function(YandexMapController)? onMapCreated;
  final bool myLocationEnabled;
  final bool myLocationButtonEnabled;
  final bool zoomControlsEnabled;
  final bool zoomGesturesEnabled;
  final MapType mapType;
  final EdgeInsets padding;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;
  final Set<Circle> circles;

  const DefaultMap({
    Key? key,
    required this.initialCameraPosition,
    this.markers = const [],
    this.myLocationEnabled = true,
    this.myLocationButtonEnabled = true,
    this.mapType = MapType.vector,
    this.zoomControlsEnabled = true,
    this.zoomGesturesEnabled = true,
    this.padding = const EdgeInsets.all(0),
    this.gestureRecognizers = const {},
    this.circles = const {},
    this.onMapCreated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return YandexMap(
      zoomGesturesEnabled: zoomGesturesEnabled,
      mapObjects: markers,
      onMapCreated: onMapCreated,
      mapType: mapType,
      gestureRecognizers: gestureRecognizers,
    );
  }
}
