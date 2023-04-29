import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(const Duration(seconds: 3));
        controller.reset();
      }
    });
    setRotation(90);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void setRotation(int degrees) {
    final angle = degrees * pi / 180;
    animation = Tween<double>(begin: 0, end: angle).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Image Rotation"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: animation,
                child: Image.asset(
                  'assets/img.png',
                  height: 400,
                  width: 350,
                ),
                builder: (context, child) => Transform.rotate(
                  angle: animation.value,
                  child: child,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    setRotation(90);
                    controller.forward(from: 0);
                  },
                  child: const Text('Rotate'))
            ],
          ),
        ),
      ),
    );
  }
}
