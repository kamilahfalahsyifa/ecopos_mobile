import 'package:ecopos/config/ColorConfig.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.bgLight,
      appBar: AppBar(
        title: const Text("Report Screen "),
        backgroundColor: ColorConfig.bgLight,
      ),
      body: const Center(
        child: Text("Hello From Report Screen"),
      ),
    );
  }
}
