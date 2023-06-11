
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meet_the_people/constants/screens.dart';
import 'package:sizer/sizer.dart';

import '../../business_logic/cubit/profile_cubit/profile_cubit.dart';
import '../../data/di/di.dart';
import '../../data/source/local/my_shared_preferences.dart';
import '../../styles/colors.dart';
import '../../widgets/other/default_cached_network_image.dart';
import '../../widgets/other/default_list_tile.dart';
import '../../widgets/other/default_text.dart';
import '../../widgets/other/horizontal_divider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    ProfileCubit cubit = ProfileCubit.get(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  // Navigator.pushNamed(context, updateProfileRoute,
                  //     arguments: cubit.auth);
                },
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  // text: cubit.auth.data.name,
                                  text: "Александр Визер",
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                DefaultText(
                                  text: 'Профиль и редактирование',
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: defaultGray,
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Container(
                              alignment: AlignmentDirectional.centerStart,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: defaultAppWhiteColor.withOpacity(0.1),
                              ),
                              child: DefaultCachedNetworkImage(
                                padding: 20.sp,
                                iconSize: 50.sp,
                                // imageUrl: cubit.auth.data.image,
                                imageUrl: "https://i1.sndcdn.com/avatars-000290781095-i22idu-t240x240.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // InkWell(
              //   onTap: () {
              //     Navigator.pushNamed(context, changePasswordRoute,
              //         arguments: cubit.auth);
              //   },
              //   child: const DefaultListTile(
              //     title: 'Change Password',
              //     trailingIcon: Icons.lock,
              //   ),
              // ),
              const HorizontalDivider(),
              InkWell(
                onTap: () {},
                child: const DefaultListTile(
                  title: 'Пригласить друзей',
                  trailingIcon: Icons.person_add,
                ),
              ),
              const HorizontalDivider(),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, settingRoute);
                },
                child: const DefaultListTile(
                  title: 'Доступ к геолокации',
                  trailingIcon: Icons.place,
                ),
              ),
              const HorizontalDivider(),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, settingRoute);
                },
                child: const DefaultListTile(
                  title: 'Настройки',
                  trailingIcon: Icons.settings,
                ),
              ),
              const HorizontalDivider(),
              InkWell(
                onTap: () {},
                child: const DefaultListTile(
                  title: 'Информация о приложении',
                  trailingIcon: Icons.info,
                ),
              ),
              const HorizontalDivider(),
              InkWell(
                onTap: () {
                  setState(() {
                    sl<MySharedPref>().clearShared();
                    Navigator.pushNamedAndRemoveUntil(
                        context, loginRoute, (route) => false);
                  });
                },
                child: const DefaultListTile(
                  title: 'Выход',
                  trailingIcon: Icons.logout,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}