part of 'report_bloc.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object?> get props => [];
}

class ReportInitial extends ReportState {}

class ReportDetail extends ReportState {
  final String reportType;

  const ReportDetail(this.reportType);

  @override
  List<Object?> get props => [reportType];
}

// 🆕 Tambahkan ini untuk menyimpan data hasil generate
class ReportGenerated extends ReportState {
  final String reportType;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> generatedData;

  const ReportGenerated({
    required this.reportType,
    required this.startDate,
    required this.endDate,
    required this.generatedData,
  });

  @override
  List<Object?> get props => [reportType, startDate, endDate, generatedData];
}
