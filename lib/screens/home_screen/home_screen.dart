import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/providers/my_devices.dart';
import 'package:firebase/widgets/add_new_device.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

//import '/app_setting/appsetting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late TextEditingController deviceNameController;
  // late TextEditingController deviceIDController;
  // final Stream<QuerySnapshot> datastream =
  //     FirebaseFirestore.instance.collection('Neopixel').snapshots();

  // @override
  // void initState() {
  //   //Untuk ngebuat
  //   deviceNameController = TextEditingController();
  //   deviceIDController = TextEditingController();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   deviceNameController.dispose();
  //   deviceIDController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    void popUp(String espId) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("delete_device_head").tr(),
          content: const Text("delete_device_main").tr(),
          actions: <Widget>[
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, "delete_device_cancel".tr()),
              child: const Text("delete_device_cancel").tr(),
            ),
            TextButton(
              onPressed: () {
                Provider.of<MyDevices>(context, listen: false)
                    .deleteDevice('user_devices', espId);
                Navigator.pop(context, 'OK');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("TR MADE"),
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
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<MyDevices>(
                //contoh panggil fungsi provider menggunakan consumer
                child: Center(
                  child:
                      const Text("front_message", textAlign: TextAlign.center)
                          .tr(),
                ),
                builder: (ctx, myDevices, ch) => myDevices.items.isEmpty
                    ? ch!
                    : ListView.builder(
                        itemCount: myDevices.items.length,
                        itemBuilder: (ctx, i) => ListTile(
                          leading: const Icon(
                            Icons.lightbulb_outline,
                            size: 30,
                          ),
                          title: Text(
                            myDevices.items[i].name,
                            style: TextStyle(fontSize: 27),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete_forever_outlined,
                              size: 30,
                            ),
                            onPressed: () => popUp(myDevices.items[i].espId),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                'devicesetting_screen',
                                arguments: myDevices.items[i].espId);
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
