import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:refilcwatch/ui/circle_specific/animated_circle_time.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double progress = 1.0;

  void updateProgress(double newProgress) {
    setState(() {
      progress = newProgress.clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Stack(
        children: [
          Center(
              child: AnimatedCircleTime(
                  progress: progress, duration: const Duration(milliseconds: 500))),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(const Size.fromWidth(40)),
                ),
                onPressed: () {
                  updateProgress(progress - 0.1); // Update progress value
                },
                child: const Text('-'),
              )
            ],
          ))
        ],
      )),
    );
  }
}
