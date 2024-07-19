import 'package:flutter/material.dart';
import 'package:flutter_h09_app/pages/home/index.dart';

void main() async {
  // app initialization
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, title: 'H09 App', home: HomePage());
  }
}
