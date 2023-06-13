import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meet_the_people/business_logic/cubit/message_send/message_send_cubit.dart';
import 'package:meet_the_people/business_logic/cubit/message_send/message_send_state.dart';
import 'package:meet_the_people/constants/screens.dart';
import 'package:meet_the_people/styles/colors.dart' as colors;

import '../data/di/di.dart';
import '../widgets/other/default_loading_indicator.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController _phoneNumberController = TextEditingController();

  late MessageSendCubit messageSendCubit;

  @override
  void initState() {
    messageSendCubit = sl<MessageSendCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return BlocProvider(
      create: (context) => messageSendCubit,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  SvgPicture.asset(
                    'assets/images/OTP.svg',
                    width: 300,
                    height: 300,
                  ),
                  SizedBox(height: 24),
                  const Text(
                    'Добро пожаловать!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: 24),
                  const Text(
                    'Вам будет отправлен одноразовый пароль на указанный номер телефона для входа',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Montserrat',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                    child: TextField(
                      controller: _phoneNumberController,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Montserrat',
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.phone,
                      autocorrect: false,
                      inputFormatters: [
                        MaskedInputFormatter('+# (###) ###-##-##')
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  BlocConsumer<MessageSendCubit, MessageSendState>(
                    listener: (context, state) async {
                      if (state is MessageSendSuccess) {
                        await Future.delayed(const Duration(seconds: 2), () {
                          Navigator.pushReplacementNamed(
                              context, otpVerificationRoute);
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is MessageSendSuccess) {
                        return DefaultLoadingIndicator();
                      } else {
                        return ElevatedButton(
                          onPressed: () {
                           messageSendCubit.send();
                          },
                          child: Text('Получить код'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
