import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedCircleTime extends StatefulWidget {
  final double progress;
  final Duration duration;

  const AnimatedCircleTime(
      {Key? key, required this.progress, required this.duration})
      : super(key: key);

  @override
  _AnimatedCircleTimeState createState() => _AnimatedCircleTimeState();
}

class _AnimatedCircleTimeState extends State<AnimatedCircleTime>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double _oldProgress;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _oldProgress = widget.progress;

    _animation =
        Tween<double>(begin: _oldProgress, end: widget.progress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addListener(() {
            setState(() {});
          });

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedCircleTime oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.progress != oldWidget.progress) {
      _oldProgress = oldWidget.progress;
      _controller.duration = widget.duration;
      _animation =
          Tween<double>(begin: _oldProgress, end: widget.progress).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      )..addListener(() {
              setState(() {});
            });
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0.02 * MediaQuery.of(context).size.width +
          6), // Add padding around the circle
      child: Stack(
        children: [
          CustomPaint(
            painter: _GrayCirclePainter(),
            child: const Center(),
          ),
          CustomPaint(
            painter: CirclePainter(_animation.value),
            child: const Center(),
          ),
        ],
      ),
    );
  }
}

double _degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}

class CirclePainter extends CustomPainter {
  final double progress;

  CirclePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFF9ABCFF)
      ..strokeWidth = 10 // Increase the stroke width for a thicker circle
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Make the stroke ends rounded

    double radius = size.width / 2;
    Offset center = Offset(size.width / 2, size.height / 2);

    double startAngle =
        _degreesToRadians(-60); // Start angle hardcoded to 60 degrees
    double endAngle =
        _degreesToRadians(239); // End angle hardcoded to -60 degrees
    double sweepAngle = endAngle - startAngle;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _GrayCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFF202124)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double radius = size.width / 2;
    Offset center = Offset(size.width / 2, size.height / 2);
    double startAngle =
        _degreesToRadians(-60); // Same start angle as the blue circle
    double endAngle =
        _degreesToRadians(239); // Same end angle as the blue circle

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      endAngle - startAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
