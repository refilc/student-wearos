
import 'package:flutter/material.dart';
import 'package:refilcwatch/ui/circle_specific/animated_circle_time.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double progress = 1.0;

  void updateProgress(double newProgress) {
    setState(() {
      progress = newProgress.clamp(0.001, 1.0); // hulye fix, azert hogy a kor ne tunjon el teljesen
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
                  progress: progress, duration: const Duration(milliseconds: 200))),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(const Size.fromWidth(40)),
                ),
                onPressed: () {
                  updateProgress(progress - 0.01); // Update progress value
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
