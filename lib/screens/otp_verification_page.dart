import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:meet_the_people/constants/screens.dart';
import 'package:meet_the_people/styles/colors.dart' as colors;

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  late List<TextStyle?> otpTextStyles;
  late List<TextEditingController?> controls;
  int numberOfFields = 5;
  bool clearText = false;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Введите код подтверждения",
                style: theme.textTheme.headlineSmall,
              ),
              SizedBox(height: 16),
              Spacer(flex: 2),
              OtpTextField(
                numberOfFields: numberOfFields,
                borderColor: Color(0xFF512DA8),
                focusedBorderColor: Colors.black,
                fieldWidth: 50,
                clearText: clearText,
                showFieldAsBox: true,
                textStyle: theme.textTheme.titleLarge,
                onCodeChanged: (String value) {
                  //Handle each value
                },
                handleControllers: (controllers) {
                  //get all textFields controller, if needed
                  controls = controllers;
                },
                onSubmit: (String verificationCode) {
                  //set clear text to clear text from all fields
                  setState(() {
                    clearText = true;
                  });
                  //navigate to different screen code goes here
                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return AlertDialog(
                  //       title: Text("Verification Code"),
                  //       content: Text('Code entered is $verificationCode'),
                  //     );
                  //   },
                  // );
                  Navigator.pushReplacementNamed(
                      context, appLayoutRoute);
                }, // end onSubmit
              ),
              Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Это помогает нам верифицировать каждого пользователя",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Выслать код повторно",
                    style: theme.textTheme.bodyLarge?.apply(
                        color: colors.defaultAppColor4
                    ),
                ),
              ),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
