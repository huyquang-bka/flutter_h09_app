import 'package:flutter/material.dart';
import 'package:flutter_h09_app/components/event_card.dart';

Widget gridEventCardBuilder(List<EventCard> listEvent, int row, int column) {
  return Row(
    children: [
      for (int i = 0; i < row; i++)
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int j = 0; j < column; j++)
                listEvent[i * column + j],
            ],
          ),
        ),
    ],
  );
}