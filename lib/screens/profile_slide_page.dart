import 'package:flutter/material.dart';
import 'package:meet_the_people/business_logic/cubit/map_cubit/map_cubit.dart';
import 'package:meet_the_people/styles/colors.dart' as colors;
import 'package:sizer/sizer.dart';

import '../data/di/di.dart';
import '../styles/colors.dart';
import '../widgets/other/default_cached_network_image.dart';
import '../widgets/other/default_list_tile.dart';
import '../widgets/other/default_text.dart';
import '../widgets/other/horizontal_divider.dart';

class SlideProfile extends StatefulWidget {
  const SlideProfile({Key? key}) : super(key: key);

  @override
  State<SlideProfile> createState() => _SlideProfileState();
}

class _SlideProfileState extends State<SlideProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Михаил Ломоносов",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                ),
              ),
            ),
            IconButton(onPressed: () {
              sl<MapCubit>().closeSlider();

            }, icon: Icon(Icons.close)),
          ],
        ),
        const HorizontalDivider(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  height: 150,
                  width: 150,
                  alignment: AlignmentDirectional.center,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: DefaultCachedNetworkImage(
                    padding: 8.sp,
                    iconSize: 50.sp,
                    imageUrl:
                        "https://cdn.culture.ru/images/0b926ae7-2a2b-5e67-acbb-1867b42b890f",
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {},
          child: const DefaultListTile(
            title: 'Отправить запрос в друзья',
            trailingIcon: Icons.person_add,
          ),
        ),
        const HorizontalDivider(),
        InkWell(
          onTap: () {
            sl<MapCubit>().buildPath();
          },
          child: const DefaultListTile(
            title: 'Проложить маршрут',
            trailingIcon: Icons.location_on,
          ),
        ),
        const HorizontalDivider(),
        InkWell(
          onTap: () {},
          child: const DefaultListTile(
            title: 'Перейти в профиль',
            trailingIcon: Icons.arrow_forward_outlined,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: Icon(Icons.edit),
          label: Text('Напиши мне'),
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.defaultAppColor4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          ),
        ),
      ],
    );
  }
}
