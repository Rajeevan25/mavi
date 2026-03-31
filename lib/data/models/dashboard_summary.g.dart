// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DashboardSummary _$DashboardSummaryFromJson(Map<String, dynamic> json) =>
    _DashboardSummary(
      openJobs: (json['openJobs'] as num).toInt(),
      activeEmployees: (json['activeEmployees'] as num).toInt(),
      todayAssignments: (json['todayAssignments'] as num).toInt(),
      pendingReports: (json['pendingReports'] as num).toInt(),
    );

Map<String, dynamic> _$DashboardSummaryToJson(_DashboardSummary instance) =>
    <String, dynamic>{
      'openJobs': instance.openJobs,
      'activeEmployees': instance.activeEmployees,
      'todayAssignments': instance.todayAssignments,
      'pendingReports': instance.pendingReports,
    };
