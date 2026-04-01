// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GuardEntry _$GuardEntryFromJson(Map<String, dynamic> json) => _GuardEntry(
  name: json['name'] as String,
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  pause: json['pause'] as String,
  total: json['total'] as String,
);

Map<String, dynamic> _$GuardEntryToJson(_GuardEntry instance) =>
    <String, dynamic>{
      'name': instance.name,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'pause': instance.pause,
      'total': instance.total,
    };

_Report _$ReportFromJson(Map<String, dynamic> json) => _Report(
  id: json['id'] as String,
  reportNumber: json['reportNumber'] as String? ?? '2024-0001',
  jobId: json['jobId'] as String,
  location: json['location'] as String,
  clientAddress: json['clientAddress'] as String? ?? '',
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
  isOutOfBounds: json['isOutOfBounds'] as bool? ?? false,
  calculatedPay: (json['calculatedPay'] as num?)?.toDouble() ?? 0.0,
  breakDurationHours: (json['breakDurationHours'] as num?)?.toDouble() ?? 0.0,
  guards:
      (json['guards'] as List<dynamic>?)
          ?.map((e) => GuardEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ReportToJson(_Report instance) => <String, dynamic>{
  'id': instance.id,
  'reportNumber': instance.reportNumber,
  'jobId': instance.jobId,
  'location': instance.location,
  'clientAddress': instance.clientAddress,
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
  'isOutOfBounds': instance.isOutOfBounds,
  'calculatedPay': instance.calculatedPay,
  'breakDurationHours': instance.breakDurationHours,
  'guards': instance.guards,
};
