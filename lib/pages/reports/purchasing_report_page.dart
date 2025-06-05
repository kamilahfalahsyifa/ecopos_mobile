import 'package:ecopos/data/bloc/blocs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/report_form_widget.dart';

class PurchasingReportPage extends StatelessWidget {
  const PurchasingReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Purchasing Report"),
          leading: const BackButton(),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: ReportFormWidget(),
        ),
      ),
    );
  }
}
