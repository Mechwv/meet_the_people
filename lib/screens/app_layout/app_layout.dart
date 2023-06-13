import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet_the_people/business_logic/cubit/people_cubit/people_cubit.dart';
import 'package:meet_the_people/screens/map/map.dart';

import '../../business_logic/cubit/profile_cubit/profile_cubit.dart';
import '../../constants/constant_methods.dart';
import '../../data/di/di.dart';
import '../profile/profile_screen.dart';

class AppLayout extends StatefulWidget {
  final int? route;
  const AppLayout({Key? key, this.route}) : super(key: key);

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  late int _selectedIndex;
  static const List<Widget> _navigationBarScreenList = <Widget>[
    MapPage(),
    ProfileScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    _selectedIndex = widget.route ?? 0;
    locationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ProfileCubit>()..getProfileInfo(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => sl<PeopleCubit>()..getPeopleNear(),
          lazy: false,
        ),
      ],
      child: Scaffold(
        body:
        SafeArea(child: _navigationBarScreenList.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Карта',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Чат',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Профиль',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
