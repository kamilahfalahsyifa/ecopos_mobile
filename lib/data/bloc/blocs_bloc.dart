import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs_event.dart';
import 'blocs_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(const ReportState()) {
    on<StartDateChanged>((event, emit) {
      emit(state.copyWith(startDate: event.startDate));
    });

    on<EndDateChanged>((event, emit) {
      emit(state.copyWith(endDate: event.endDate));
    });

    on<GenerateReport>((event, emit) {
      // TODO: implement generate logic
    });

    on<PrintReport>((event, emit) {
      // TODO: implement print logic
    });

    on<DownloadPdfReport>((event, emit) {
      // TODO: implement download PDF logic
    });

    on<NavigateToDetailReport>((event, emit) {
      emit(state.copyWith(reportType: event.reportType));
    });

    on<SelectReportType>((event, emit) {
  emit(state.copyWith(reportType: event.reportType));
});

  }
}
