import 'package:ecopos/config/ColorConfig.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.bgLight,
      appBar: AppBar(
        title: const Text("Setting Screen "),
        backgroundColor: ColorConfig.bgLight,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Text(
          'About',
          style: TextStyle(color: ColorConfig.textDark),
        ),
      ),
    );
  }
}
