import 'dart:io';
import 'package:flutter/foundation.dart';

class Device {
  final String id;
  final String espId;
  final String name;

  Device({
    required this.id,
    required this.espId,
    required this.name,
  });
}
