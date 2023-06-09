import 'package:flutter/material.dart';
import 'package:meet_the_people/widgets/top_row.dart';
import 'package:meet_the_people/widgets/top_switch.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  bool isPeopleSelected = true; // Track the selected state of the switch

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Expanded(
            child: YandexMap(
              onMapCreated: (YandexMapController controller) {
                // Perform map setup and configuration here
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24.0), // Add 16.0 units of top padding
            child: CustomRow(),
          ),
        ],
      ),
    );
  }
}