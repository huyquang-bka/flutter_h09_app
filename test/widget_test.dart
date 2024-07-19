// Function to load a list of cameras from a JSON configuration string
import 'dart:convert';
import 'package:flutter_h09_app/models/camera.dart';

List<Camera> loadCamerasFromConfig(String config) {
  List<dynamic> jsonList = json.decode(config);
  print(jsonList);
  return jsonList.map((jsonItem) => Camera.fromJson(jsonItem)).toList();
}

void main() async {
  // app initialization
  loadCamerasFromConfig('assets/configs/camera.json');
}