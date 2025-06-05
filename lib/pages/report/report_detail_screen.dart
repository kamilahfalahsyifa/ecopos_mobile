import 'package:flutter/material.dart';

class ReportDetailScreen extends StatelessWidget {
  final String reportType;

  const ReportDetailScreen({super.key, required this.reportType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDFDFF),
      appBar: AppBar(
        title: Text(reportType),
        backgroundColor: Color(0xFFFDFDFF),
      ),
      body: Center(
        child: Text("Showing $reportType here..."),
      ),
    );
  }
}
