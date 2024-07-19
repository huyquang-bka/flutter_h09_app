import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_h09_app/components/event_card.dart';
import 'package:flutter_h09_app/components/event_view.dart';
import 'package:flutter_h09_app/helpers/helpers_function.dart';
import 'package:flutter_h09_app/models/camera.dart';
import 'package:flutter_h09_app/models/event.dart';
import 'package:flutter_h09_app/screen/camera.dart';
import 'package:web_socket_client/web_socket_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Camera> cameras = [];
  List<EventCard> listEvent = List.generate(
      4,
      (index) => EventCard(
          event: Event(name: '', time: '?', image: '', cameraUrl: '')));
  final backoff = LinearBackoff(
    initial: const Duration(seconds: 0),
    increment: const Duration(seconds: 1),
    maximum: const Duration(seconds: 2),
  );
  late WebSocket socket;

  @override
  void initState() {
    _loadCameras();
    _loadSocket();
    super.initState();
  }

  Future<void> _loadCameras() async {
    try {
      String data = await rootBundle.loadString('assets/configs/camera.json');
      List<Camera> camerasFromConfig = loadCamerasFromConfig(data);
      setState(() {
        for (Camera camera in camerasFromConfig) {
          camera.id = cameras.length;
          camera.events = listEvent;
          cameras.add(camera);
        }
      });
    } catch (e) {
      print("Error loading cameras: $e");
    }
  }

  Future<void> _loadSocket() async {
    try {
      String hostJson =
          await rootBundle.loadString('assets/configs/socket.json');
      final String host = jsonDecode(hostJson)['host'];
      socket = WebSocket(Uri.parse(host), backoff: backoff);
      socket.messages.listen((message) {
        _handleSocketMessage(message);
      });
      socket.connection.listen((event) {
        print('Socket connected');
      });
    } catch (e) {
      print("Error loading socket: $e");
    }
  }

  void _handleSocketMessage(String message) {
    final jsonMessage = jsonDecode(message);
    final String rtsp = jsonMessage['rtsp'];
    for (Camera camera in cameras) {
      if (camera.rtsp == rtsp) {
        Event event = Event.fromJson(jsonMessage);
        // Update the event list of the camera, pop the oldest event and push the new event
        setState(() {
          camera.events.removeAt(0);
          camera.events.add(EventCard(event: event));
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //body is a column of CameraView widgets from the cameras list
        body: cameras.isEmpty
            ? const Center(
                child:
                    CircularProgressIndicator()) // Show loading indicator while data is being fetched
            : Row(
                children: [
                  for (Camera camera in cameras)
                    CameraView(
                      camera: camera,
                      listEventCard: camera.events,
                    ),
                ],
              ));
  }
}

class CameraView extends StatefulWidget {
  final Camera camera;
  final List<EventCard> listEventCard;

  const CameraView(
      {super.key, required this.camera, required this.listEventCard});

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
