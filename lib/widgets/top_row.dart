import 'package:flutter/material.dart';
import 'package:meet_the_people/widgets/top_switch.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.0,
      padding: const EdgeInsets.only(top: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.search, size: 32.0),
          ),
          Expanded(child: SwitchableWidget()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.settings, size: 32.0),
          ),
        ],
      ),
    );
  }
}