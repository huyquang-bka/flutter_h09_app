import 'package:flutter/material.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter_h09_app/models/camera.dart';

class CameraScreen extends StatefulWidget {
  final Camera camera;
  final bool isPlayerInitialized;

  const CameraScreen({super.key, required this.camera, this.isPlayerInitialized = true});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late Player player;

  @override
  void initState() {
    super.initState();
    DartVLC.initialize();
    if (widget.isPlayerInitialized) {
      _initPlayer();
    }
  }

  void _initPlayer() {
    player = Player(id: widget.camera.id);
    player.open(Media.network(widget.camera.rtsp));
  }

  @override
  void didUpdateWidget(CameraScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlayerInitialized != oldWidget.isPlayerInitialized && widget.isPlayerInitialized) {
      _initPlayer();
    }
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
    return Video(player: player, showControls: true);
  }
}
