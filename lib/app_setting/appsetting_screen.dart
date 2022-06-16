import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CLARA"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, 'devicesetting_screen');
                },
                icon: Icon(
                  Icons.language,
                ),
                label: Text(
                  'LANGUAGE',
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo,
                  elevation: 10,
                ),
              ),
              margin: EdgeInsets.all(10),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, 'theme_screen');
                },
                icon: Icon(
                  Icons.palette,
                ),
                label: Text(
                  'THEME',
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo,
                  elevation: 10,
                ),
              ),
              margin: EdgeInsets.all(10),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, 'aboutus_screen');
                },
                icon: Icon(
                  Icons.people_alt_rounded,
                ),
                label: Text(
                  'ABOUTUS',
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo,
                  elevation: 10,
                ),
              ),
              margin: EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }
}
