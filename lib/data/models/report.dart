import 'package:freezed_annotation/freezed_annotation.dart';

part 'report.freezed.dart';
part 'report.g.dart';

@freezed
abstract class GuardEntry with _$GuardEntry {
  const factory GuardEntry({
    required String name,
    required String startTime,
    required String endTime,
    required String pause,
    required String total,
  }) = _GuardEntry;

  factory GuardEntry.fromJson(Map<String, dynamic> json) => _$GuardEntryFromJson(json);
}

@freezed
abstract class Report with _$Report {
  const factory Report({
    required String id,
    @Default('2024-0001') String reportNumber,
    required String jobId,
    required String location,
    @Default('') String clientAddress,
    required DateTime date,
    required String workStart,
    required String workEnd,
    required String notes,
    @Default([]) List<String> photoUrls,
    required String signedBy,
    String? exportedPdf,
    @Default('Routine') String reportType,
    @Default('low') String severity,
    @Default(false) bool isIncident,
    String? weather,
    @Default(false) bool policeNotified,
    String? signatureUrl,
    @Default(false) bool isOutOfBounds,
    @Default(0.0) double calculatedPay,
    @Default(0.0) double breakDurationHours,
    @Default([]) List<GuardEntry> guards,
  }) = _Report;

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
}
