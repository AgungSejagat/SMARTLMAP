import 'package:flutter/material.dart';
import '../providers/my_devices.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AddNewDevice extends StatefulWidget {
  const AddNewDevice({Key? key}) : super(key: key);

  @override
  State<AddNewDevice> createState() => _AddNewDeviceState();
}

class _AddNewDeviceState extends State<AddNewDevice> {
  final _deviceNameController = TextEditingController();
  final _deviceIDController = TextEditingController();
  final _deviceRooomController = TextEditingController();

  String _scanBarcode = 'Unknown';


  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      _deviceIDController.text = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    void isExist(String name) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("greeting_scan_exist_head").tr(),
              content: Text(
                  'The device you scanned was saved with the name \'$name\''),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            );
          });
    }

    void _saveDevice() {
      if (_deviceNameController.text.isEmpty ||
          _deviceIDController.text.isEmpty) {
        return;
      }

      final selectedDevice = Provider.of<MyDevices>(context, listen: false)
          .findById(_deviceIDController.text);
      if (selectedDevice.espId == '0') {
        Provider.of<MyDevices>(context, listen: false)
            .addDevice(_deviceIDController.text, _deviceNameController.text, _deviceRooomController.text);
        Navigator.of(context).pop();
      } else {
        isExist(selectedDevice.name);
      }
    }

    return Container(
      padding: const EdgeInsets.all(15),
      //color: Colors.indigo,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: const Text(
              "greeting_device",
              style: TextStyle(fontSize: 20),
            ).tr(),
          ),
          const SizedBox(
            height: 22,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "greeting_device_name".tr(),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
            ),
            controller: _deviceNameController,
            //style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 22,
          ),
          Row(
            children: [
              Flexible(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "greeting_scan_id".tr(),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                  controller: _deviceIDController,
                ),
              ),
              IconButton(
                  onPressed: () => scanBarcodeNormal(),
                  icon: const Icon(Icons.camera)),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("greeting_cancel").tr(),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _saveDevice,
                child: const Text("greeting_add").tr(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
