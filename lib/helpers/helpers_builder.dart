import 'package:flutter/material.dart';
import 'package:flutter_h09_app/components/event_card.dart';

Widget gridEventCardBuilder(List<EventCard> listEvent, int column, int row) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      for (int i = 0; i < listEvent.length; i += column)
        Row(
          children: [
            for (int j = 0; j < column; j++)
              if (i + j < listEvent.length)
                Expanded(
                  child: listEvent[i + j],
                )
          ],
        )
    ],
  );
}
