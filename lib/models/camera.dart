// Define the Camera class
import 'package:flutter_h09_app/components/event_card.dart';

class Camera {
  String rtsp;
  String title;
  String direction;
  int id;
  List<EventCard> events = [];

  Camera({
    required this.rtsp,
    required this.title,
    required this.direction,
    this.id = 0,
  });

  // Factory method to create a Camera instance from a JSON map
  factory Camera.fromJson(Map<String, dynamic> json) {
    return Camera(
      rtsp: json['rtsp'],
      title: json['title'],
      direction: json['direction'],
    );
  }

  //override toString
  @override
  String toString() {
    return 'Camera{rtsp: $rtsp, title: $title, direction: $direction}, id: $id';
  }

  // Convert a Camera instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'rtsp': rtsp,
      'title': title,
      'direction': direction,
      'id': id,
    };
  }
}
