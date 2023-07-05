import 'package:countdown/common/config/theme/app_theme.dart';
import 'package:countdown/module/timer/view/countdown_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countdown',
      theme: AppTheme.lightTheme,
      home: const CountdownApp(),
    );
  }
}

class CountdownApp extends StatefulWidget {
  const CountdownApp({super.key});

  @override
  State<CountdownApp> createState() => _CountdownAppState();
}

class _CountdownAppState extends State<CountdownApp> {
  @override
  Widget build(BuildContext context) {
    return const CountdownScreen();
  }
}
