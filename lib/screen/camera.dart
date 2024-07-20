import 'package:flutter/material.dart';
import 'package:flutter_h09_app/models/camera.dart';
import 'package:dart_vlc/dart_vlc.dart';

class CameraScreen extends StatefulWidget {
  final Camera camera;
  const CameraScreen({super.key, required this.camera});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late Player player;

  @override
  void initState() {
    player = Player(id: widget.camera.id);
    player.open(Media.network(widget.camera.rtsp));
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        border: Border.all(color: Colors.black),
      ),
      child: PlayerWidget(player: player),
    );
  }
}

class PlayerWidget extends StatelessWidget {
  final Player player;
  const PlayerWidget({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Video(player: player, showControls: false);
  }
}
