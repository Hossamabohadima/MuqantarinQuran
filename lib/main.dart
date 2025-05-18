import 'package:flutter/material.dart';
import 'HelpScreen.dart';

import 'ScrollingImageScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/ScrollingImageScreen": (context) => ScrollingImageScreen(),
        '/Help': (context) => HelpScreen(),
      },
      initialRoute: "/ScrollingImageScreen",
    );
  }
}
