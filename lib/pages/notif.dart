import 'package:ecopos/config/ColorConfig.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.bgLight,
      appBar: AppBar(
        title: const Text("Notification Screen "),
        backgroundColor: ColorConfig.bgLight,
      ),
      body: const Center(
        child: Text("Hello From Notification Screen"),
      ),
    );
  }
}
