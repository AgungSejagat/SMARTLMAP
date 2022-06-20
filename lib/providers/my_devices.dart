import 'dart:io';
import 'package:flutter/foundation.dart';
import '../helpers/db_helper.dart';
import '../models/device.dart';

class MyDevices with ChangeNotifier {
  List<Device> _items = [];

  List<Device> get items {
    return [..._items];
  }

  Device findById(String id) {
    return _items.firstWhere((Device) => Device.id == id);
  }

  Future<void> addDevice(
    String pickedEspId,
    String pickedName,
  ) async {
    final newDevice = Device(
      id: DateTime.now().toString(),
      espId: pickedEspId,
      name: pickedName,
    );
    _items.add(newDevice);
    notifyListeners();
    DBHelper.insert('user_devices', {
      'id': newDevice.id,
      'espId': newDevice.espId,
      'name': newDevice.name,
    });
  }

  Future<void> fetchAndSetDevices() async {
    final dataList = await DBHelper.getData('user_devices');
    _items = dataList
        .map(
          (item) => Device(
            id: item['id'],
            espId: item['espId'],
            name: item['name'],
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> deleteDevice(String table, String selectedId) async {
    await DBHelper.delete(table, selectedId);
    fetchAndSetDevices();
  }
}
