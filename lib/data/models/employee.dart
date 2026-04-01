import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee.freezed.dart';
part 'employee.g.dart';

enum EmployeeStatus {
  @JsonValue('available') available,
  @JsonValue('on_duty') onDuty,
  @JsonValue('unavailable') unavailable,
  @JsonValue('on_break') onBreak,
}

@freezed
abstract class Employee with _$Employee {
  const factory Employee({
    required String id,
    required String name,
    required String role,
    @Default(EmployeeStatus.available) EmployeeStatus status,
    required String phone,
    required String email,
    required String availability,
    String? avatarUrl,
    @Default(5.0) double rating,
    @Default(0) int experienceYears,
    @Default([]) List<String> certifications,
    @Default(['Deutsch']) List<String> languages,
    String? emergencyContact,
    @Default(false) bool isVerified,
    String? idNumber,
    DateTime? criminalRecordDate,
    @Default([]) List<String> driverLicenseClasses,
    @Default(false) bool weaponsPermit,
    DateTime? firstAidExpiry,
    String? uniformSize,
    @Default(0.0) double earnedBalance,
    @Default(25.0) double hourlyRate,
  }) = _Employee;

  factory Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);
}
