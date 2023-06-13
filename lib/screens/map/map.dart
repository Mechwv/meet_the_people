import 'package:flutter/material.dart';
import 'package:meet_the_people/business_logic/cubit/map_cubit/map_controller.dart';
import 'package:meet_the_people/business_logic/cubit/map_cubit/map_cubit.dart';
import 'package:meet_the_people/widgets/top_row.dart';
import 'package:meet_the_people/widgets/top_switch.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../data/di/di.dart';
import '../profile_slide_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _controller = MapController();

  final double _initFabHeight = 70.0;
  double? _fabHeight = null;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;

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
                    SlidingUpPanel(
                      panel: SlideProfile(),
                      minHeight: 50,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          topRight: Radius.circular(18.0)),
                      onPanelSlide: (double pos) => setState(() {
                        _fabHeight = 4.7*pos * (_panelHeightClosed - _panelHeightOpen) +
                            _initFabHeight;
                      }),
                      body: YandexMap(
                        mapObjects: model.mapObjects,
                        onMapCreated: model.onMapCreated,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: _fabHeight ?? 64.0 , right: 16.0),
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
