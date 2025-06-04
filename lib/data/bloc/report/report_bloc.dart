import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportInitial()) {
    on<NavigateToReportDetail>((event, emit) {
      emit(ReportDetail(event.reportType));
    });
    on<GenerateReport>((event, emit) {
  // Dummy data (bisa diganti logic generate sebenarnya)
  final dummyData = ["Data 1", "Data 2", "Data 3"];

  emit(ReportGenerated(
    reportType: event.reportType,
    startDate: event.startDate,
    endDate: event.endDate,
    generatedData: dummyData,
  ));
});

  }
}
