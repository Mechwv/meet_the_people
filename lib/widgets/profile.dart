import 'package:flutter/material.dart';
import 'package:meet_the_people/styles/colors.dart' as colors;

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile Page'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60.0,
                    backgroundImage: AssetImage('assets/images/house.png'), // Replace with your large profile icon image
                    backgroundColor: Colors.grey[300],
                  ),
                  Positioned(
                    top: 8.0,
                    left: 8.0,
                    child: CircleAvatar(
                      radius: 12.0,
                      backgroundColor: colors.defaultAppColor4,
                      child: Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.0),
              Text(
                'Александр Визер',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                  '+79689983066',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {},
                child: Text('Редактировать профиль'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.defaultAppColor4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
              SizedBox(height: 24.0),
              Row(
                children: [
                  Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.power_settings_new,
                      color: colors.defaultAppColor4,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Text(
                      'Выйти',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.red,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}