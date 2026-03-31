import 'package:freezed_annotation/freezed_annotation.dart';

part 'report.freezed.dart';
part 'report.g.dart';

@freezed
abstract class Report with _$Report {
  const factory Report({
    required String id,
    required String jobId,
    required String location,
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
  }) = _Report;

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);
}
