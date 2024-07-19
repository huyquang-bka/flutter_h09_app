import 'package:flutter/material.dart';
import 'package:flutter_h09_app/components/event_card.dart';
import 'package:flutter_h09_app/helpers/helpers_builder.dart';

Container eventScreen(List<EventCard> listEvent) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white30,
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        border: Border.all(color: Colors.black),
      ),
      //ListTile of event cards
      child: gridEventCardBuilder(listEvent, 2, 2),
    );
  }