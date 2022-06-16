import 'package:flutter/material.dart';
import '/app_setting/appsetting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CLARA"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        actions: [
          IconButton(
            //monggo bang
            onPressed: () {
              Navigator.pushNamed(context, 'appsetting_screen');
            },
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(15),
                color: Colors.indigo,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Please input your product information",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    Text(
                      "Device Name:",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                    Text(
                      "Device ID:",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        ElevatedButton(onPressed: () {Navigator.pop(context);}, child: Text("Cancel")),
                        ElevatedButton(onPressed: () {Navigator.pop(context);}, child: Text("Continue"))
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            )
          ],
        ),
        elevation: 12,
        backgroundColor: Colors.indigo,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
