import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_h09_app/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    Uint8List imageBytes = base64Decode(event.image);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Use a proportion of the container's width as the font size
        double imageWidth = constraints.maxWidth * 0.4;
        double imageHeight = constraints.maxWidth * 0.4;
        double fontSize = constraints.maxWidth * 0.04;
      return Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color(0xFF2F4F4F), // Dark Slate Gray background
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: imageWidth,
                height: imageHeight,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Center(
                  child: event.image.isNotEmpty
                      ? Image.memory(imageBytes, fit: BoxFit.cover)
                      : const Icon(
                          Icons.image_not_supported,
                          size: 48,
                          color: Colors.white,
                        ),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              flex: 3,
              child: SizedBox(
                height: imageHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoChip('Thời gian', event.time, fontSize: fontSize),
                    _buildInfoChip('Trạng thái', event.cameraUrl, fontSize: fontSize),
                    _buildInfoChip('Họ tên', event.name, fontSize: fontSize),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
    );
  }

  Widget _buildInfoChip(String label, String value, {double fontSize = 16}) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Text(
            '$label: $value',
            style: TextStyle(color: Colors.white, fontSize: fontSize),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }
}
