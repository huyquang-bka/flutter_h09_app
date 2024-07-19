// Define the Camera class
class Camera {
  String rtsp;
  String title;
  String direction;

  Camera({required this.rtsp, required this.title, required this.direction});

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
    return 'Camera{rtsp: $rtsp, title: $title, direction: $direction}';
  }

  // Convert a Camera instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'rtsp': rtsp,
      'title': title,
      'direction': direction,
    };
  }
}