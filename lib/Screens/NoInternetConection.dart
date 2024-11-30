import 'package:flutter/material.dart';

class InternetConectionScreen extends StatefulWidget {
  const InternetConectionScreen({super.key});

  @override
  State<InternetConectionScreen> createState() => _InternetConectionScreenState();
}

class _InternetConectionScreenState extends State<InternetConectionScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('No internet connection'),
      ),
    );
  }
}