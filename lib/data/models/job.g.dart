// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Job _$JobFromJson(Map<String, dynamic> json) => _Job(
  id: json['id'] as String,
  title: json['title'] as String,
  location: json['location'] as String,
  date: DateTime.parse(json['date'] as String),
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  serviceType: json['serviceType'] as String,
  status:
      $enumDecodeNullable(_$JobStatusEnumMap, json['status']) ?? JobStatus.open,
  assignedEmployeeIds:
      (json['assignedEmployeeIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  notes: json['notes'] as String?,
  clientName: json['clientName'] as String?,
  contactPhone: json['contactPhone'] as String?,
);

Map<String, dynamic> _$JobToJson(_Job instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'location': instance.location,
  'date': instance.date.toIso8601String(),
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'serviceType': instance.serviceType,
  'status': _$JobStatusEnumMap[instance.status]!,
  'assignedEmployeeIds': instance.assignedEmployeeIds,
  'notes': instance.notes,
  'clientName': instance.clientName,
  'contactPhone': instance.contactPhone,
};

const _$JobStatusEnumMap = {
  JobStatus.open: 'open',
  JobStatus.inProgress: 'in_progress',
  JobStatus.completed: 'completed',
  JobStatus.cancelled: 'cancelled',
};
