import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ananlytics"),
      ),
      body: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ColoredBox(
          color: Colors.grey.shade100,
          child: const SizedBox(
            height: double.infinity,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
