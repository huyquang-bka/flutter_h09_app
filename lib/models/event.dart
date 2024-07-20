class Event {
  final String name;
  final String time;
  final String image; // base64 encoded string
  final String rtsp;

  Event({
    required this.name,
    required this.time,
    required this.image,
    required this.rtsp,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'],
      time: json['time'],
      image: json['image'],
      rtsp: json['rtsp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'time': time,
      'image': image,
      'rtsp': rtsp,
    };
  }
}
