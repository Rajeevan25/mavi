import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/kpi_card.dart';
import '../../core/widgets/map_placeholder.dart';
import '../../core/widgets/skeleton_loader.dart';
import '../../data/models/job.dart';
import '../../data/models/employee.dart';
import '../../data/models/notification_item.dart';
import '../../data/repositories/job_repository.dart';
import '../../data/repositories/employee_repository.dart';
import '../../data/repositories/report_repository.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  int _getWeekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysOffset =
        firstDayOfYear.weekday > 4 ? 8 - firstDayOfYear.weekday : 1 - firstDayOfYear.weekday;
    final firstMonday = firstDayOfYear.add(Duration(days: daysOffset));
    final diff = date.difference(firstMonday).inDays;
    return (diff / 7).floor() + (diff >= 0 ? 1 : 0);
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return 'Guten Morgen';
    if (hour >= 12 && hour < 18) return 'Guten Tag';
    if (hour >= 18 && hour < 23) return 'Guten Abend';
    return 'Gute Nacht';
  }

  /// Returns a human-readable time-ago string for a job's start time.
  String _timeAgo(Job job) {
    try {
      final parts = job.startTime.split(':');
      final jobStart = DateTime(
        job.date.year, job.date.month, job.date.day,
        int.parse(parts[0]), int.parse(parts[1]),
      );
      final diff = DateTime.now().difference(jobStart);
      if (diff.inMinutes < 1) return 'Gerade eben';
      if (diff.inMinutes < 60) return 'Vor ${diff.inMinutes} Min.';
      if (diff.inHours < 24) return 'Vor ${diff.inHours} Std.';
      return 'Vor ${diff.inDays} Tg.';
    } catch (_) {
      return job.startTime;
    }
  }

  /// Resolves assigned employee IDs to a display string.
  String _staffLabel(Job job, List<Employee> employees) {
    if (job.assignedEmployeeIds.isEmpty) return 'Kein Personal zugewiesen';
    final names = job.assignedEmployeeIds.map((id) {
      try {
        return employees.firstWhere((e) => e.id == id).name.split(' ').first;
      } catch (_) {
        return id;
      }
    }).toList();
    return names.join(', ');
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final jobs = ref.watch(jobRepositoryProvider);
    final employees = ref.watch(employeeRepositoryProvider);
    final reports = ref.watch(reportRepositoryProvider);
    final notifications = ref.watch(notificationRepositoryProvider);

    final openJobs = jobs.where((j) => j.status == JobStatus.open).length;
    final activeEmployees =
        employees.where((e) => e.status == EmployeeStatus.onDuty).length;
    final todayAssignments =
        jobs.where((j) => DateUtils.isSameDay(j.date, DateTime.now())).length;
    final pendingReports =
        reports.where((r) => r.exportedPdf == null).length;
    final inProgressCount =
        jobs.where((j) => j.status == JobStatus.inProgress).length;
    final unreadCount =
        notifications.where((n) => !n.isRead).length;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, unreadCount),
              const SizedBox(height: 6),
              _buildGreeting(),
              const SizedBox(height: 20),
              _buildUrgentAlert(
                  notifications
                      .where((n) => n.type == NotificationType.urgent && !n.isRead)
                      .firstOrNull),
              const SizedBox(height: 24),
              _buildKpiGrid(openJobs, activeEmployees, todayAssignments, pendingReports),
              const SizedBox(height: 32),
              _buildPlanningHeader(),
              const SizedBox(height: 12),
              _buildCalendarStrip(context),
              const SizedBox(height: 32),
              _buildQuickActionsHeader(),
              const SizedBox(height: 16),
              _buildQuickActionsGrid(context),
              const SizedBox(height: 32),
              _buildRecentActivityHeader(context),
              const SizedBox(height: 16),
              _buildRecentActivityList(jobs, employees, _isLoading),
              const SizedBox(height: 32),
              _buildLiveOverviewMap(inProgressCount),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ── Widgets ───────────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context, int unreadCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Symbols.security, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'MAVI Security',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.0,
                    color: AppColors.primaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
        Stack(
          children: [
            IconButton(
              onPressed: () => context.push('/notifications'),
              icon: const Icon(Symbols.notifications, color: AppColors.primaryContainer),
            ),
            if (unreadCount > 0)
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${_greeting()}, Markus',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.navyDeep,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '$day.$month.$year',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.onSurface.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  Widget _buildUrgentAlert(NotificationItem? alert) {
    if (alert == null) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.errorContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Symbols.warning, color: AppColors.errorDark, fill: 1),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'DRINGENDE MELDUNG',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                    color: AppColors.errorDark.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  alert.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.errorDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  alert.message,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.errorDark.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKpiGrid(int open, int active, int today, int pending) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.6,
      children: [
        KpiCard(title: 'Offene Aufträge', value: '$open', icon: Symbols.assignment),
        KpiCard(
          title: 'Aktives Personal',
          value: '$active',
          icon: Symbols.badge,
          color: AppColors.primaryContainer,
          textColor: Colors.white,
          iconColor: Colors.white.withOpacity(0.5),
        ),
        KpiCard(title: 'Anstehend heute', value: '$today', icon: Symbols.event),
        KpiCard(
          title: 'Ausstehende Berichte',
          value: '$pending',
          icon: Symbols.description,
          textColor: AppColors.error,
          iconColor: AppColors.error,
        ),
      ],
    );
  }

  Widget _buildPlanningHeader() {
    final now = DateTime.now();
    int weekNumber = _getWeekNumber(now);
    if (weekNumber < 1) weekNumber = 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Einsatzplanung',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryContainer,
          ),
        ),
        Text(
          'KW $weekNumber',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarStrip(BuildContext context) {
    final now = DateTime.now();
    final currentDay = now.weekday;
    final monday = now.subtract(Duration(days: currentDay - 1));
    final days = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];

    return GestureDetector(
      onTap: () => context.go('/planning'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (i) {
            final date = monday.add(Duration(days: i));
            final isToday = DateUtils.isSameDay(date, now);
            return Expanded(
              child: Column(
                children: [
                  Text(
                    days[i],
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isToday ? AppColors.primaryContainer : AppColors.neutral100,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${date.day}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isToday ? Colors.white : AppColors.onSurface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildQuickActionsHeader() {
    return const Text(
      'Schnellzugriff',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryContainer),
    );
  }

  Widget _buildQuickActionsGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.2,
      children: [
        _buildActionButton(context, Symbols.add_task, 'Neuer Auftrag',
            AppColors.card1, AppColors.primaryContainer,
            () => context.push('/jobs/create')),
        _buildActionButton(context, Symbols.post_add, 'Bericht erstellen',
            AppColors.card2, AppColors.slate,
            () => context.push('/reports/create')),
        _buildActionButton(context, Symbols.manage_accounts, 'Personal',
            AppColors.card3, AppColors.textDark,
            () => context.go('/employees')),
        _buildActionButton(context, Symbols.calendar_view_week, 'Schichtplan',
            AppColors.card4, AppColors.navyLight,
            () => context.go('/planning')),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label,
      Color bgColor, Color iconColor, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.onSurface.withOpacity(0.05)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2)),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                    color: bgColor, borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.navyDeep),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivityHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Letzte Aktivitäten',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryContainer),
        ),
        TextButton(
          onPressed: () => context.go('/jobs'),
          child: const Text(
            'ALLE SEHEN',
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.primaryContainer),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivityList(List<Job> jobs, List<Employee> employees, bool isLoading) {
    if (isLoading) {
      return Column(
        children: List.generate(3, (index) => const ActivitySkeletonLoader()),
      );
    }

    final activityJobs = jobs
        .where((j) =>
            j.status == JobStatus.inProgress || j.status == JobStatus.completed)
        .toList();

    if (activityJobs.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Text(
            'Keine laufenden Aktivitäten.',
            style: TextStyle(color: Colors.black.withOpacity(0.4)),
          ),
        ),
      );
    }

    return Column(
      children: activityJobs.take(3).map((job) {
        final isActive = job.status == JobStatus.inProgress;
        final staffLabel = _staffLabel(job, employees);
        final timeLabel = _timeAgo(job);

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border(
              left: BorderSide(
                color: isActive ? AppColors.navyDeep : AppColors.neutral200,
                width: 4,
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                    color: AppColors.surfaceVariant, shape: BoxShape.circle),
                child: Icon(
                  isActive ? Symbols.shield : Symbols.domain_verification,
                  color: isActive ? AppColors.navyDeep : AppColors.slate,
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
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.onSurface),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$timeLabel • $staffLabel',
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.onSurface.withOpacity(0.6)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (isActive)
                const Row(
                  children: [
                    Icon(Symbols.fiber_manual_record,
                        color: AppColors.primaryContainer, size: 10),
                    SizedBox(width: 4),
                    Text(
                      'AKTIV',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryContainer),
                    ),
                  ],
                )
              else
                const Icon(Symbols.check_circle,
                    color: AppColors.navyDeep, size: 20, fill: 1),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLiveOverviewMap(int inProgressCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Live Standort-Übersicht',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryContainer),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          width: double.infinity,
          child: Stack(
            children: [
              const MapPlaceholder(height: 180),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    children: [
                      const Icon(Symbols.fiber_manual_record,
                          color: AppColors.navyDeep, size: 12),
                      const SizedBox(width: 8),
                      Text(
                        '$inProgressCount ${inProgressCount == 1 ? 'PATROUILLE' : 'PATROUILLEN'} ONLINE',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: AppColors.navyDeep,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
