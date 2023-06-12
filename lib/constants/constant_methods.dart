import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../business_logic/cubit/global_cubit/global_cubit.dart';
import '../data/di/di.dart';
import '../styles/colors.dart';
import 'constants.dart';

void printResponse(String text) {
  if (kDebugMode) {
    print('\x1B[33m$text\x1B[0m');
  }
}

void printError(String text) {
  if (kDebugMode) {
    print('\x1B[31m$text\x1B[0m');
  }
}

void printTest(String text) {
  if (kDebugMode) {
    print('\x1B[32m$text\x1B[0m');
  }
}

void showToastMsg({required String msg, required ToastStates toastState}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state: toastState),
      textColor: Colors.black,
      fontSize: 16.0);
}

Color chooseToastColor({required ToastStates state}) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = defaultAppColor2;
      break;
    case ToastStates.warning:
      color = Colors.white;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
  }
  return color;
}

// Future<String> convertPositionToAddress({
//   required double lat,
//   required double lon,
// }) async {
//   List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lon);
//   Placemark place = placeMarks[0];
//   printTest('$lat,$lon');
//   printTest(place.toString());
//   return '${place.country} ${place.locality}  ${place.subLocality}';
// }

Future<Position> locationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    printError('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      printError('Location permissions are denied');

      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    printError(
        'Location permissions are permanently denied, we cannot request permissions.');
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
// printTest(position.longitude.toString());
// printTest(position.latitude.toString());
// printTest(position .toString());

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return position;
}

Future<Position> backgroundLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      printError('Location permissions are denied');

      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    printError(
        'Location permissions are permanently denied, we cannot request permissions.');
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
// printTest(position.longitude.toString());
// printTest(position.latitude.toString());
// printTest(position .toString());

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return position;
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

Future<Uint8List> getBytesFromAsset(String path, double width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width.toInt());
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

List<String> uuidGen(int size) {
  List<String> uuids = [];
  for (var i = 0; i < size; i++) {
    uuids.add(Uuid().v4());
  }
  return uuids;
}

Future multipartConvertImage({
  required XFile image,
}) async {
  return MultipartFile.fromFileSync(image.path,
      filename: image.path.split('/').last);
}

Future<XFile?> pickImage(ImageSource source) async {
  XFile? image = await ImagePicker().pickImage(
      source: source, maxHeight: 1024, maxWidth: 1024, imageQuality: 50);
  if (image != null) {
    return image;
  } else {
    return null;
  }
}

Color darkOrLightColor(Color lightColor, Color darkColor) {
  return sl<GlobalCubit>().isLightTheme ? lightColor : darkColor;
}

Future<BitmapDescriptor> downloadResizePictureCircle(
  String imageUrl, {
  int size = 150,
  bool addBorder = false,
  Color borderColor = Colors.white,
  double borderSize = 10,
}) async {
  final File imageFile = await DefaultCacheManager().getSingleFile(imageUrl);

  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint paint = Paint()..color;

  final double radius = size / 2;

  //make canvas clip path to prevent image drawing over the circle
  final Path clipPath = Path();
  clipPath.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
      Radius.circular(100)));
/* clipPath.addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, size * 8 / 10, size.toDouble(), size * 3 / 10),
        Radius.circular(100))); */
  canvas.clipPath(clipPath);

  //paintImage
  final Uint8List imageUint8List = await imageFile.readAsBytes();
  final ui.Codec codec = await ui.instantiateImageCodec(imageUint8List);
  final ui.FrameInfo imageFI = await codec.getNextFrame();
  paintImage(
      fit: BoxFit.cover,
      alignment: Alignment.center,
      canvas: canvas,
      rect: Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
      image: imageFI.image);

  if (addBorder) {
  //draw Border
    paint..color = borderColor;
    paint..style = PaintingStyle.stroke;
    paint..strokeWidth = borderSize;
    canvas.drawCircle(Offset(radius, radius), radius, paint);
  }

//convert canvas as PNG bytes
  final _image =
      await pictureRecorder.endRecording().toImage(size, (size * 1.1).toInt());
  final data = await _image.toByteData(format: ui.ImageByteFormat.png);

//convert PNG bytes as BitmapDescriptor
  return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
}
