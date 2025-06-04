import 'package:ecopos/pages/reports/cashier_report_page.dart';
import 'package:ecopos/pages/reports/product_report_page.dart';
import 'package:ecopos/pages/reports/purchasing_report_page.dart';
import 'package:ecopos/pages/reports/selling_report_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecopos/data/bloc/report/report_bloc.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportBloc(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFDFDFF),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFDFDFF),
          elevation: 0,
          title: const Text(
            "Report",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildReportItem(context, "Selling Report"),
              const SizedBox(height: 16),
              _buildReportItem(context, "Product Report"),
              const SizedBox(height: 16),
              _buildReportItem(context, "Cashier Report"),
              const SizedBox(height: 16),
              _buildReportItem(context, "Purchasing Report"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReportItem(BuildContext context, String label) {
    return GestureDetector(
      onTap: () {
        switch (label) {
          case "Selling Report":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SellingReportPage()),
            );
            break;
          case "Product Report":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProductReportPage()),
            );
            break;
          case "Cashier Report":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CashierReportPage()),
            );
            break;
          case "Purchasing Report":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PurchasingReportPage()),
            );
            break;
          default:
            // Fallback (opsional)
            break;
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF313DC5)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.insert_drive_file, color: Colors.black),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
