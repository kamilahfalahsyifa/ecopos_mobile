import 'package:ecopos/data/bloc/blocs_bloc.dart';
import 'package:ecopos/data/bloc/blocs_event.dart';
import 'package:ecopos/data/bloc/blocs_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ReportFormWidget extends StatelessWidget {
  const ReportFormWidget({super.key});

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      final bloc = context.read<ReportBloc>();
      if (isStartDate) {
        bloc.add(StartDateChanged(pickedDate));
      } else {
        bloc.add(EndDateChanged(pickedDate));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportBloc, ReportState>(
      builder: (context, state) {
        final dateFormat = DateFormat.yMMMMd(); // Format: March 20, 2025

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Start date"),
            GestureDetector(
              onTap: () => _selectDate(context, true),
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: state.startDate != null
                        ? dateFormat.format(state.startDate!)
                        : "Select date",
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text("End date"),
            GestureDetector(
              onTap: () => _selectDate(context, false),
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: state.endDate != null
                        ? dateFormat.format(state.endDate!)
                        : "Select date",
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => context.read<ReportBloc>().add(GenerateReport()),
                  child: const Text("Generate"),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () => context.read<ReportBloc>().add(PrintReport()),
                  child: const Text("Print"),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () => context.read<ReportBloc>().add(DownloadPdfReport()),
                  child: const Text("Download as PDF"),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
