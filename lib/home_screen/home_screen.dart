import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/device_setting/devicesetting_screen.dart';
import 'package:firebase/helpers/db_helper.dart';
import 'package:firebase/providers/my_devices.dart';
import 'package:firebase/widgets/add_new_device.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import '/app_setting/appsetting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController deviceNameController;
  late TextEditingController deviceIDController;
  final Stream<QuerySnapshot> datastream =
      FirebaseFirestore.instance.collection('Neopixel').snapshots();

  @override
  void initState() {
    //Untuk ngebuat
    deviceNameController = TextEditingController();
    deviceIDController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    deviceNameController.dispose();
    deviceIDController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TR Smart Lamp"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'appsetting_screen');
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<MyDevices>(context, listen: false).fetchAndSetDevices(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<MyDevices>(
                    child: const Center(
                      child: Text(
                          'Have you got your device?\nClick the + button bellow to add yours!',
                          textAlign: TextAlign.center),
                    ),
                    builder: (ctx, myDevices, ch) => myDevices.items.isEmpty
                        ? ch!
                        : ListView.builder(
                            itemCount: myDevices.items.length,
                            itemBuilder: (ctx, i) => ListTile(
                              leading: const Icon(Icons.lightbulb_outline),
                              title: Text(myDevices.items[i].name),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_forever_outlined),
                                onPressed: () {
                                 Provider.of<MyDevices>(context, listen: false).deleteDevice('user_devices', myDevices.items[i].espId);
                                },
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    'devicesetting_screen',
                                    arguments: myDevices.items[i].id);
                              },
                            ),
                          ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return AddNewDevice();
            },
          );
        },
        elevation: 12,
        backgroundColor: Colors.indigo,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
