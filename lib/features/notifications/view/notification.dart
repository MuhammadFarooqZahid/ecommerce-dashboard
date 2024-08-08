import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notificatons"),
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
