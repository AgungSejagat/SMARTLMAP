import 'package:flutter/material.dart';
import '../providers/my_devices.dart';
import 'package:provider/provider.dart';

class AddNewDevice extends StatefulWidget {
  const AddNewDevice({Key? key}) : super(key: key);

  @override
  State<AddNewDevice> createState() => _AddNewDeviceState();
}

class _AddNewDeviceState extends State<AddNewDevice> {
  final _deviceNameController = TextEditingController();
  final _deviceIDController = TextEditingController();

  void _saveDevice() {
    if (_deviceNameController.text.isEmpty ||
        _deviceIDController.text.isEmpty) {
      return;
    }
    Provider.of<MyDevices>(context, listen: false)
        .addDevice(_deviceIDController.text, _deviceNameController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      //color: Colors.indigo,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Please input your product information",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          // const Text(
          //   "Device Name:",
          //   style: TextStyle(fontSize: 15, color: Colors.white),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Device name: ',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
            ),
            controller: _deviceNameController,
            //style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 22,
          ),
          // const Text(
          //   "Device ID:",
          //   style: TextStyle(fontSize: 15, color: Colors.white),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Device ID: ',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
            ),
            controller: _deviceIDController,
            //style: const TextStyle(color: Colors.white),
          ),
          const Spacer(),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              const Spacer(),
              ElevatedButton(
                  onPressed: _saveDevice, child: const Text("Add device"))
            ],
          )
        ],
      ),
    );
  }
}
