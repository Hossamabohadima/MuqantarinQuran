import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => Navigator.pop(context), // Optional: tap to go back
          child: SizedBox.expand(
            child: Image.asset(
              'assets/help_image.jpg',
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}

