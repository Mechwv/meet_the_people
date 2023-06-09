import 'package:flutter/material.dart';

class SwitchableWidget extends StatefulWidget {
  const SwitchableWidget({super.key});

  @override
  _SwitchableWidgetState createState() => _SwitchableWidgetState();
}

class _SwitchableWidgetState extends State<SwitchableWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 35.0,
                  decoration: BoxDecoration(
                    color: _selectedIndex == 0 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Text(
                      'Карта',
                      style: TextStyle(
                        color: _selectedIndex == 0 ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 35.0,
                  decoration: BoxDecoration(
                    color: _selectedIndex == 1 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Text(
                      'Люди',
                      style: TextStyle(
                        color: _selectedIndex == 1 ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}