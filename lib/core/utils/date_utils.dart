import 'package:intl/intl.dart';

/// Central date formatting helpers for the entire app.
/// All visible dates must go through these methods — never format inline.
class AppDateUtils {
  AppDateUtils._();

  static final _dayMonthYear = DateFormat('dd.MM.yyyy');
  static final _dayMonthYearTime = DateFormat('dd.MM.yyyy, HH:mm');
  static final _timeOnly = DateFormat('HH:mm');

  /// e.g. "31.03.2026"
  static String formatDate(DateTime date) => _dayMonthYear.format(date);

  /// e.g. "31.03.2026, 18:00"
  static String formatDateTime(DateTime date) =>
      _dayMonthYearTime.format(date);

  /// Human-readable time-ago string.
  static String timeAgo(DateTime timestamp) {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inSeconds < 60) return 'Gerade eben';
    if (diff.inMinutes < 60) return 'Vor ${diff.inMinutes} Min.';
    if (diff.inHours < 24) return 'Vor ${diff.inHours} Std.';
    if (diff.inDays == 1) return 'Gestern';
    return 'Vor ${diff.inDays} Tagen';
  }
}
