import 'package:ecopos/config/ColorConfig.dart';
import 'package:flutter/material.dart';

class POSScreen extends StatelessWidget {
  const POSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.bgLight,
      appBar: AppBar(
        title: const Text("POS Screen "),
        backgroundColor: ColorConfig.bgLight,
      ),
      body: const Center(
        child: Text("Hello From POS Screen"),
      ),
    );
  }
}
