// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Report _$ReportFromJson(Map<String, dynamic> json) => _Report(
  id: json['id'] as String,
  jobId: json['jobId'] as String,
  location: json['location'] as String,
  date: DateTime.parse(json['date'] as String),
  workStart: json['workStart'] as String,
  workEnd: json['workEnd'] as String,
  notes: json['notes'] as String,
  photoUrls:
      (json['photoUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  signedBy: json['signedBy'] as String,
  exportedPdf: json['exportedPdf'] as String?,
  reportType: json['reportType'] as String? ?? 'Routine',
  severity: json['severity'] as String? ?? 'low',
  isIncident: json['isIncident'] as bool? ?? false,
  weather: json['weather'] as String?,
  policeNotified: json['policeNotified'] as bool? ?? false,
  signatureUrl: json['signatureUrl'] as String?,
);

Map<String, dynamic> _$ReportToJson(_Report instance) => <String, dynamic>{
  'id': instance.id,
  'jobId': instance.jobId,
  'location': instance.location,
  'date': instance.date.toIso8601String(),
  'workStart': instance.workStart,
  'workEnd': instance.workEnd,
  'notes': instance.notes,
  'photoUrls': instance.photoUrls,
  'signedBy': instance.signedBy,
  'exportedPdf': instance.exportedPdf,
  'reportType': instance.reportType,
  'severity': instance.severity,
  'isIncident': instance.isIncident,
  'weather': instance.weather,
  'policeNotified': instance.policeNotified,
  'signatureUrl': instance.signatureUrl,
};
