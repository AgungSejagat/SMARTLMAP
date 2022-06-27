//Untuk mengatur state secara individu, seperti tambah dan hapus device tanpa refresh satu poge

import 'dart:io';
import '../helpers/db_helper.dart';
import '../models/device.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MyDevices with ChangeNotifier {
  List<Device> _items = [];

  List<Device> get items {
    return [..._items];
  }

  Device findById(String id) {
    final nullDevice = Device(
      espId: '0',
      name: '0',
      room: '0'
    );
    return _items.firstWhere((Device) => Device.espId == id,
        orElse: (() => nullDevice));
  }

  Future<void> addDevice(
    String pickedEspId,
    String pickedName,
    String pickedRoom,
  ) async {
    final newDevice = Device(
      //id: DateTime.now().toString(),
      espId: pickedEspId,
      name: pickedName,
      room: pickedRoom,
    );
    _items.add(newDevice);
    notifyListeners();
    DBHelper.insert('user_devices', {
      'espId': newDevice.espId,
      'name': newDevice.name,
    });
  }

  Future<void> fetchAndSetDevices() async {
    final dataList = await DBHelper.getData('user_devices');
    _items = dataList
        .map(
          (item) => Device(
            espId: item['espId'],
            name: item['name'],
            room: item['room'],
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> deleteDevice(String table, String selectedId) async {
    await DBHelper.delete(table, selectedId);
    fetchAndSetDevices();
  }

  Future<void> changeLanguage(BuildContext context, String languageCode) async {
    context.setLocale(Locale(languageCode));
    notifyListeners();
  }
}
