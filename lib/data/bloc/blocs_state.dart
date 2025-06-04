import 'package:equatable/equatable.dart';

class ReportState extends Equatable {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? reportType; // ✅ tambahkan field ini

  const ReportState({
    this.startDate,
    this.endDate,
    this.reportType, // ✅ tambahkan ke konstruktor
  });

  ReportState copyWith({
    DateTime? startDate,
    DateTime? endDate,
    String? reportType, // ✅ tambahkan di copyWith
  }) {
    return ReportState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reportType: reportType ?? this.reportType, // ✅ salin field
    );
  }

  @override
  List<Object?> get props => [startDate, endDate, reportType]; // ✅ tambahkan ke props
}
