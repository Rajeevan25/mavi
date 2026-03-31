import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/date_utils.dart';
import '../../data/repositories/job_repository.dart';
import '../../data/models/job.dart';
import '../../data/repositories/employee_repository.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

class PlanningScreen extends ConsumerStatefulWidget {
  const PlanningScreen({super.key});

  @override
  ConsumerState<PlanningScreen> createState() => _PlanningScreenState();
}

class _PlanningScreenState extends ConsumerState<PlanningScreen> {
  DateTime _selectedDate = DateTime.now();

  // ── Date helpers ────────────────────────────────────────────────────────

  int _getWeekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysOffset =
        firstDayOfYear.weekday > 4 ? 8 - firstDayOfYear.weekday : 1 - firstDayOfYear.weekday;
    final firstMonday = firstDayOfYear.add(Duration(days: daysOffset));
    final diff = date.difference(firstMonday).inDays;
    return (diff / 7).floor() + (diff >= 0 ? 1 : 0);
  }

  String _getMonthName(int month) {
    const months = [
      'JANUAR', 'FEBRUAR', 'MÄRZ', 'APRIL', 'MAI', 'JUNI',
      'JULI', 'AUGUST', 'SEPTEMBER', 'OKTOBER', 'NOVEMBER', 'DEZEMBER'
    ];
    return months[month - 1];
  }

  List<DateTime> _getWeekDays(DateTime targetDate) {
    final weekday = targetDate.weekday;
    final monday = targetDate.subtract(Duration(days: weekday - 1));
    return List.generate(7, (i) => monday.add(Duration(days: i)));
  }

  void _goToPreviousWeek() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 7));
    });
  }

  void _goToNextWeek() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 7));
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryContainer,
              onPrimary: Colors.white,
              onSurface: AppColors.navyDeep,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final jobs = ref.watch(jobsByDateProvider(_selectedDate));

    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        title: const Text('Schichtplanung'),
        actions: [
          IconButton(
            onPressed: () => _selectDate(context),
            icon: const Icon(Symbols.calendar_today),
            tooltip: 'Datum wählen',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWeekHeader(),
            const SizedBox(height: 24),
            _buildCalendarGrid(),
            const SizedBox(height: 32),
            const Text(
              'TAGESÜBERSICHT',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  color: Colors.grey),
            ),
            const SizedBox(height: 16),
            if (jobs.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Center(
                  child: Text(
                    'Keine Schichten für diesen Tag geplant.',
                    style:
                        TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
              )
            else
              ...jobs.map((job) => _buildShiftItem(job)),
          ],
        ),
      ),
    );
  }

  // ── Widgets ──────────────────────────────────────────────────────────────

  Widget _buildWeekHeader() {
    final weekNumber = _getWeekNumber(_selectedDate);
    final isCurrentWeek =
        _getWeekNumber(DateTime.now()) == weekNumber &&
        _selectedDate.year == DateTime.now().year;

    return Row(
      children: [
        IconButton(
          onPressed: _goToPreviousWeek,
          icon: const Icon(Symbols.chevron_left, size: 24),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          color: AppColors.slate,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'KW ${weekNumber > 0 ? weekNumber : ''} • ${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    color: Colors.grey),
              ),
              if (isCurrentWeek)
                const Text(
                  'Aktuelle Woche',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryContainer),
                ),
            ],
          ),
        ),
        IconButton(
          onPressed: _goToNextWeek,
          icon: const Icon(Symbols.chevron_right, size: 24),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          color: AppColors.slate,
        ),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    final weekDays = _getWeekDays(_selectedDate);
    final dayNames = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: dayNames
                .map((d) => SizedBox(
                      width: 36,
                      child: Center(
                        child: Text(d,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),
          _buildCalendarRow(weekDays),
        ],
      ),
    );
  }

  Widget _buildCalendarRow(List<DateTime> dates) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(dates.length, (i) {
        final date = dates[i];
        final isSelected = DateUtils.isSameDay(date, _selectedDate);
        final isToday = DateUtils.isSameDay(date, DateTime.now());

        return GestureDetector(
          onTap: () => setState(() => _selectedDate = date),
          child: Container(
            width: 36,
            height: 48,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryContainer : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${date.day}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? Colors.white
                        : isToday
                            ? AppColors.primaryContainer
                            : AppColors.navyDeep,
                  ),
                ),
                // Small dot for today (when not selected)
                if (isToday && !isSelected)
                  Container(
                    width: 4,
                    height: 4,
                    margin: const EdgeInsets.only(top: 2),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                  ),
                // White dot when selected + today
                if (isSelected)
                  const CircleAvatar(radius: 2, backgroundColor: Colors.white),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildShiftItem(Job job) {
    // FIX: use ref.watch so this reactively updates
    final employees = ref.watch(employeeRepositoryProvider);

    final bool isUnassigned = job.assignedEmployeeIds.isEmpty;
    final Color color = isUnassigned ? Colors.orange : AppColors.primaryContainer;

    final String personnelInfo;
    if (isUnassigned) {
      personnelInfo = 'Nicht zugewiesen';
    } else {
      final assignedNames = job.assignedEmployeeIds.map((id) {
        return employees.where((e) => e.id == id).firstOrNull?.name ?? id;
      }).toList();
      personnelInfo = assignedNames.join(', ');
    }

    return InkWell(
      onTap: () => context.push('/jobs/${job.id}'),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border(left: BorderSide(color: color, width: 4)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Symbols.schedule,
                          size: 14,
                          color: isUnassigned ? Colors.orange : Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        '${job.startTime} - ${job.endTime}',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isUnassigned ? Colors.orange : Colors.grey),
                      ),
                      const Spacer(),
                      if (isUnassigned)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text('Offen',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    job.title,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppColors.navyDeep),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                          isUnassigned ? Symbols.person_off : Symbols.person,
                          size: 14,
                          color: isUnassigned
                              ? Colors.orange
                              : Colors.black.withOpacity(0.6)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          personnelInfo,
                          style: TextStyle(
                              fontSize: 13,
                              color: isUnassigned
                                  ? Colors.orange
                                  : Colors.black.withOpacity(0.6),
                              fontWeight: isUnassigned
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            const Icon(Symbols.chevron_right, size: 20, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
