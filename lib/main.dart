import 'package:flutter/material.dart';
import 'package:flutter_h09_app/pages/home/index.dart';
import 'package:window_size/window_size.dart';

void main() async {
  // app initialization
  WidgetsFlutterBinding.ensureInitialized();
  // set min window size
  setWindowMinSize(const Size(1400, 900));
  // set window name
  setWindowTitle('Kiểm soát ra vào H09');
  DartVLC.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kiểm soát ra vào H09',
      home: HomePage(),
    );
  }
}
