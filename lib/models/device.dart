//Untuk memudahkan penulisan/pembuatan database, terutama espId dan nama

import 'dart:io';
import 'package:flutter/foundation.dart';

class Device {
  final String espId;
  final String name;
  final String room;

  Device({
    required this.espId,
    required this.name,
    required this.room,
  });
}