import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_h09_app/components/event_card.dart';
import 'package:flutter_h09_app/components/event_view.dart';
import 'package:flutter_h09_app/helpers/helpers_function.dart';
import 'package:flutter_h09_app/models/camera.dart';
import 'package:flutter_h09_app/models/event.dart';
import 'package:flutter_h09_app/screen/camera.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Camera> cameras = [];
  List<EventCard> listEventIn = [
      EventCard(event: Event(name: 'Nguyễn Huy Quang', time: '?', image: '', cameraUrl: '')),
      EventCard(event: Event(name: 'Nguyễn A B', time: '?', image: '', cameraUrl: '')),
      EventCard(event: Event(name: 'Hoàng Thị Vân Anh Anh Anh', time: '?', image: '', cameraUrl: '')),
      EventCard(event: Event(name: '?', time: '?', image: '', cameraUrl: '')),
    ];
  
  List<EventCard> listEventOut = [
      EventCard(event: Event(name: 'Mai Hồng Ngọc', time: '?', image: '', cameraUrl: '')),
      EventCard(event: Event(name: '?', time: '?', image: '', cameraUrl: '')),
      EventCard(event: Event(name: '?', time: '?', image: '', cameraUrl: '')),
      EventCard(event: Event(name: '?', time: '?', image: '', cameraUrl: '')),
    ];
  
  @override
  void initState() {
    _loadCameras();
    super.initState();
  }

  Future<void> _loadCameras() async {
    try
    {
      String data = await rootBundle.loadString('assets/configs/camera.json');
      List<Camera> camerasFromConfig = loadCamerasFromConfig(data);
      setState(() {
        cameras = camerasFromConfig;
      });
    } catch (e) {
      print("Error loading cameras: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body is a column of CameraView widgets from the cameras list
      body: cameras.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator while data is being fetched
          : Row(
            children: [
              for (Camera camera in cameras)
                CameraView(camera: camera, listEventCard: camera.direction == 'in' ? listEventIn : listEventOut),
            ],
          )
    );
  }
}

class CameraView extends StatefulWidget {
  final Camera camera;
  final List<EventCard> listEventCard;

  const CameraView({super.key, required this.camera, required this.listEventCard});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //Title of the camera
              Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(bottom: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: Text(
                    widget.camera.title,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              //camera view
              Expanded(
                flex: 5,
                child: CameraScreen(camera: widget.camera),
              ),
              //show grid event card
              Expanded(
                flex: 4,
                child: eventScreen(widget.listEventCard),
              ),
            ],
          ),
        ),
      ),
    );
  }
}