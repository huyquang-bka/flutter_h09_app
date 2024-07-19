class Event {
  final String name;
  final String time;
  final String image; // base64 encoded string
  final String cameraUrl;

  Event({
    required this.name,
    required this.time,
    required this.image,
    required this.cameraUrl,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'],
      time: json['time'],
      image: json['image'],
      cameraUrl: json['camera_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'time': time,
      'image': image,
      'camera_url': cameraUrl,
    };
  }
}
