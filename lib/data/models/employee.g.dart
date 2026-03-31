// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Employee _$EmployeeFromJson(Map<String, dynamic> json) => _Employee(
  id: json['id'] as String,
  name: json['name'] as String,
  role: json['role'] as String,
  status:
      $enumDecodeNullable(_$EmployeeStatusEnumMap, json['status']) ??
      EmployeeStatus.available,
  phone: json['phone'] as String,
  email: json['email'] as String,
  availability: json['availability'] as String,
  avatarUrl: json['avatarUrl'] as String?,
  rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
  experienceYears: (json['experienceYears'] as num?)?.toInt() ?? 0,
  certifications:
      (json['certifications'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  languages:
      (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const ['Deutsch'],
  emergencyContact: json['emergencyContact'] as String?,
  isVerified: json['isVerified'] as bool? ?? false,
  idNumber: json['idNumber'] as String?,
  criminalRecordDate: json['criminalRecordDate'] == null
      ? null
      : DateTime.parse(json['criminalRecordDate'] as String),
  driverLicenseClasses:
      (json['driverLicenseClasses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  weaponsPermit: json['weaponsPermit'] as bool? ?? false,
  firstAidExpiry: json['firstAidExpiry'] == null
      ? null
      : DateTime.parse(json['firstAidExpiry'] as String),
  uniformSize: json['uniformSize'] as String?,
);

Map<String, dynamic> _$EmployeeToJson(_Employee instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'role': instance.role,
  'status': _$EmployeeStatusEnumMap[instance.status]!,
  'phone': instance.phone,
  'email': instance.email,
  'availability': instance.availability,
  'avatarUrl': instance.avatarUrl,
  'rating': instance.rating,
  'experienceYears': instance.experienceYears,
  'certifications': instance.certifications,
  'languages': instance.languages,
  'emergencyContact': instance.emergencyContact,
  'isVerified': instance.isVerified,
  'idNumber': instance.idNumber,
  'criminalRecordDate': instance.criminalRecordDate?.toIso8601String(),
  'driverLicenseClasses': instance.driverLicenseClasses,
  'weaponsPermit': instance.weaponsPermit,
  'firstAidExpiry': instance.firstAidExpiry?.toIso8601String(),
  'uniformSize': instance.uniformSize,
};

const _$EmployeeStatusEnumMap = {
  EmployeeStatus.available: 'available',
  EmployeeStatus.onDuty: 'on_duty',
  EmployeeStatus.unavailable: 'unavailable',
  EmployeeStatus.onBreak: 'on_break',
};
