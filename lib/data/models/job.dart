import 'package:freezed_annotation/freezed_annotation.dart';

part 'job.freezed.dart';
part 'job.g.dart';

enum JobStatus {
  @JsonValue('open') open,
  @JsonValue('in_progress') inProgress,
  @JsonValue('completed') completed,
  @JsonValue('cancelled') cancelled,
}

@freezed
abstract class Job with _$Job {
  const factory Job({
    required String id,
    required String title,
    required String location,
    required DateTime date,
    required String startTime,
    required String endTime,
    required String serviceType,
    @Default(JobStatus.open) JobStatus status,
    @Default([]) List<String> assignedEmployeeIds,
    String? notes,
    String? clientName,
    String? contactPhone,
    double? targetLatitude,
    double? targetLongitude,
  }) = _Job;

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);
}
