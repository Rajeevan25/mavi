import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:intl/intl.dart';
import 'package:mavi_security/core/theme/app_colors.dart';
import 'package:mavi_security/data/models/employee.dart';
import 'package:mavi_security/data/models/report.dart';
import 'package:mavi_security/data/repositories/employee_repository.dart';
import 'package:mavi_security/data/repositories/report_repository.dart';
import 'package:mavi_security/data/repositories/job_repository.dart';

class EmployeeWalletScreen extends ConsumerWidget {
  final String employeeId;
  const EmployeeWalletScreen({required this.employeeId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employee = ref.watch(employeeRepositoryProvider).firstWhere((e) => e.id == employeeId);
    final reports = ref.watch(reportRepositoryProvider);
    final jobs = ref.watch(jobRepositoryProvider);

    // Filter reports where this employee is a guard
    final employeeReports = reports.where((report) {
      return report.guards.any((guard) => guard.name == employee.name);
    }).toList();

    // Sort by date descending
    employeeReports.sort((a, b) => b.date.compareTo(a.date));

    // Group by week
    final groupedReports = _groupReportsByWeek(employeeReports);

    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        title: Text('${employee.name.split(' ').first}s Wallet'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.navyDeep,
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildSummaryHeader(employee, employeeReports),
          ),
          for (var entry in groupedReports.entries) ...[
            _buildWeekHeader(entry.key, entry.value),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final report = entry.value[index];
                  final job = jobs.firstWhere((j) => j.id == report.jobId);
                  return _buildServiceItem(report, job, employee.hourlyRate);
                },
                childCount: entry.value.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildSummaryHeader(Employee employee, List<Report> reports) {
    final totalEarnings = reports.fold(0.0, (sum, r) => sum + (r.calculatedPay > 0 ? r.calculatedPay : _estimatePay(r, employee.hourlyRate)));
    
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          const Text(
            'GESAMTVERDIENST',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: AppColors.textGrey,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${totalEarnings.toStringAsFixed(2)} CHF',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: AppColors.navyDeep,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSimpleStat('Einsätze', '${reports.length}'),
              Container(width: 1, height: 40, color: AppColors.outlineVariant),
              _buildSimpleStat('Stundensatz', '${employee.hourlyRate} CHF'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.navyDeep),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.textGrey, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildWeekHeader(String weekLabel, List<Report> reports) {
    final weeklyTotal = reports.fold(0.0, (sum, r) => sum + (r.calculatedPay > 0 ? r.calculatedPay : 0.0));
    final weeklyHours = reports.length * 8.0; // Mocking hours for complexity

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  weekLabel.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: AppColors.navyDeep,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  _getWeekRangeString(reports.first.date),
                  style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${weeklyTotal.toStringAsFixed(2)} CHF',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: AppColors.primaryContainer,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(Report report, dynamic job, double rate) {
    final pay = report.calculatedPay > 0 ? report.calculatedPay : _estimatePay(report, rate);
    final durationStr = report.guards.firstWhere((g) => g.name.contains('Markus') || g.name.contains('e1'), orElse: () => report.guards.first).total;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.backgroundAlt,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getIconForReportType(report.reportType),
                color: AppColors.navyDeep,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.navyDeep),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Icon(Symbols.calendar_today, size: 12, color: AppColors.textGrey),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('dd.MM.yyyy').format(report.date),
                          style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Symbols.schedule, size: 12, color: AppColors.textGrey),
                        const SizedBox(width: 4),
                        Text(
                          '${report.workStart} - ${report.workEnd} ($durationStr)',
                          style: const TextStyle(fontSize: 11, color: AppColors.textGrey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${pay.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: AppColors.navyDeep),
                ),
                const Text(
                  'CHF',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textGrey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Map<String, List<Report>> _groupReportsByWeek(List<Report> reports) {
    final Map<String, List<Report>> groups = {};
    for (var report in reports) {
      final weekNum = _getWeekNumber(report.date);
      final key = 'Woche $weekNum';
      if (!groups.containsKey(key)) {
        groups[key] = [];
      }
      groups[key]!.add(report);
    }
    return groups;
  }

  int _getWeekNumber(DateTime date) {
    // Simple week number calculation
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysSinceFirstDay = date.difference(firstDayOfYear).inDays;
    return (daysSinceFirstDay / 7).ceil();
  }

  String _getWeekRangeString(DateTime date) {
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    return '${DateFormat('dd.MM.').format(startOfWeek)} - ${DateFormat('dd.MM.').format(endOfWeek)}';
  }

  double _estimatePay(Report report, double rate) {
    // fallback if calculatedPay is 0
    return 8.0 * rate; 
  }

  IconData _getIconForReportType(String type) {
    switch (type.toLowerCase()) {
      case 'incident': return Symbols.warning;
      case 'alarm': return Symbols.notifications_active;
      case 'routine': return Symbols.task_alt;
      default: return Symbols.description;
    }
  }
}
