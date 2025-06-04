abstract class ReportEvent {}

class StartDateChanged extends ReportEvent {
  final DateTime startDate;
  StartDateChanged(this.startDate);
}

class EndDateChanged extends ReportEvent {
  final DateTime endDate;
  EndDateChanged(this.endDate);
}

class GenerateReport extends ReportEvent {}

class PrintReport extends ReportEvent {}

class DownloadPdfReport extends ReportEvent {}

class NavigateToDetailReport extends ReportEvent {
  final String reportType;
  NavigateToDetailReport(this.reportType);
}

class SelectReportType extends ReportEvent {
  final String reportType;
  SelectReportType(this.reportType);
}