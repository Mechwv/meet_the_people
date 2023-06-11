import 'package:flutter/material.dart';
import 'package:meet_the_people/screens/otp_page.dart';
import 'package:meet_the_people/constants/screens.dart' as screens;
import 'package:meet_the_people/screens/otp_verification_page.dart';

import '../screens/map/map.dart';
import '../screens/profile/profile_screen.dart';
import '../widgets/profile.dart';
import 'custom_page_route.dart';

class AppRouter {
  late Widget startScreen;

  Route? onGenerateRoute(RouteSettings settings) {

    switch (settings.name) {
      case screens.otpVerificationRoute:
        return CustomPageRoute(
            direction: AxisDirection.down, child: const OtpVerification());
      default:
        return CustomPageRoute(
            direction: AxisDirection.down, child: ProfileScreen());
    }
  }
}
