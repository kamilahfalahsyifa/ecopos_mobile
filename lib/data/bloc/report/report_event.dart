part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object?> get props => [];
}

class NavigateToReportDetail extends ReportEvent {
  final String reportType;

  const NavigateToReportDetail(this.reportType);

  @override
  List<Object?> get props => [reportType];
}
class GenerateReport extends ReportEvent {
  final String reportType;
  final DateTime startDate;
  final DateTime endDate;

  const GenerateReport({
    required this.reportType,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [reportType, startDate, endDate];
}

