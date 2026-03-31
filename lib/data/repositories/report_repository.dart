import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/report.dart';
import '../models/notification_item.dart';
import '../mock/mock_data.dart';

part 'report_repository.g.dart';

@riverpod
class ReportRepository extends _$ReportRepository {
  @override
  List<Report> build() {
    return MockData.reports;
  }

  void addReport(Report report) {
    state = [...state, report];
  }
}

@riverpod
class NotificationRepository extends _$NotificationRepository {
  @override
  List<NotificationItem> build() {
    return MockData.notifications;
  }

  void markAsRead(String id) {
    state = [
      for (final n in state)
        if (n.id == id) n.copyWith(isRead: true) else n,
    ];
  }

  void markAllAsRead() {
    state = state.map((n) => n.copyWith(isRead: true)).toList();
  }
}
