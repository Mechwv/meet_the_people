import 'package:flutter/material.dart';
import 'package:meet_the_people/business_logic/cubit/map_cubit/map_controller.dart';
import 'package:meet_the_people/business_logic/cubit/map_cubit/map_cubit.dart';
import 'package:meet_the_people/widgets/top_row.dart';
import 'package:meet_the_people/widgets/top_switch.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../data/di/di.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _controller = MapController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Scaffold(
        body: Consumer<MapController>(builder: (context, model, child) {
          return Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  YandexMap(
                    mapObjects: model.mapObjects,
                    onMapCreated: model.onMapCreated,
                    // onUserLocationAdded: (UserLocationView view) async {
                    //   return view.copyWith(
                    //     arrow: await model.createUserMark()
                    //   );
                    // }
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0, right: 16.0),
                    child: FloatingActionButton(
                      onPressed: model.moveCameraOnUser,
                      child:
                      Icon(
                        Icons.my_location,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              CustomRow(),
            ],
          );
        }),
      ),
    );
  }
}
