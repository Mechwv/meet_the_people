import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet_the_people/business_logic/cubit/map_cubit/map_controller.dart';
import 'package:meet_the_people/business_logic/cubit/map_cubit/map_cubit.dart';
import 'package:meet_the_people/business_logic/cubit/map_cubit/map_state.dart';
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

  double _minHeight = 0.0;

  final PanelController panelController = PanelController();

  final double _initFabHeight = 70.0;
  double _fabHeight = 64.0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 95.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Scaffold(
        body: Consumer<MapController>(builder: (context, model, child) {
          return BlocBuilder<MapCubit, MapState>(builder: (context, state) {
            return Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    SlidingUpPanel(
                      controller: panelController,
                      panel: SlideProfile(),
                      minHeight: _minHeight,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          topRight: Radius.circular(18.0)),
                      onPanelSlide: (double pos) => setState(() {
                        _fabHeight = 4.7 *
                                pos *
                                (_panelHeightClosed - _panelHeightOpen) +
                            _initFabHeight;
                      }),
                      body: YandexMap(
                        mapObjects: model.mapObjects,
                        onMapCreated: model.onMapCreated,
                      ),
                    ),
                    BlocConsumer<MapCubit, MapState>(
                      listener: (context, state) {
                        if (state is MapObjectChosen) {
                          setState(() {
                            _minHeight = 50.0;
                            panelController.show();
                          });
                        } else if (state is MapInitial) {
                          setState(() {
                            panelController.hide();
                          });
                        } else if (state is MapPathBuilt) {
                          _controller.requestRoutes();
                        } else if (state is MapPathFinished) {
                          _controller.cleanRoutes();
                        }
                      },
                      builder: (context, state) {
                        if (state is MapPathBuilt) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: _fabHeight + 64, right: 16.0),
                            child: FloatingActionButton(
                              onPressed: () => sl<MapCubit>().removePath(),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                        else {
                          return SizedBox(height: 0,);
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: _fabHeight, right: 16.0),
                      child: FloatingActionButton(
                        onPressed: model.moveCameraOnUser,
                        child: Icon(
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
          });
        }),
      ),
    );
  }
}
