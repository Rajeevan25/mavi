import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/date_utils.dart';
import '../../data/models/job.dart';
import '../../data/models/employee.dart';
import '../../data/repositories/job_repository.dart';
import '../../data/repositories/employee_repository.dart';
import '../../core/widgets/status_chip.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

class JobDetailsScreen extends ConsumerWidget {
  final String jobId;

  const JobDetailsScreen({required this.jobId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final job = ref.watch(jobByIdProvider(jobId));
    final allEmployees = ref.watch(employeeRepositoryProvider);

    if (job == null) {
      return const Scaffold(
          body: Center(child: Text('Auftrag nicht gefunden')));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Auftrag ${job.id.toUpperCase()}'),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Bearbeitungsmodus wird geladen...')));
            },
            icon: const Icon(Symbols.edit),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Auftrag wird geteilt...')));
            },
            icon: const Icon(Symbols.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusHeader(job),
            const SizedBox(height: 32),
            _buildSection('Kerninformationen', [
              _buildInfoRow(Symbols.work, 'Dienstleistung', job.serviceType),
              _buildInfoRow(
                  Symbols.location_on, 'Standort', job.location),
              _buildInfoRow(
                  Symbols.calendar_today,
                  'Datum',
                  AppDateUtils.formatDate(job.date)),
              _buildInfoRow(Symbols.schedule, 'Zeitraum',
                  '${job.startTime} - ${job.endTime}'),
            ]),
            const SizedBox(height: 32),
            _buildSection('Kunde', [
              _buildInfoRow(Symbols.person, 'Name',
                  job.clientName ?? 'Nicht angegeben'),
              _buildInfoRow(Symbols.phone, 'Kontakt',
                  job.contactPhone ?? 'Nicht angegeben'),
            ]),
            const SizedBox(height: 32),
            _buildSection('Zugeordnetes Personal', [
              if (job.assignedEmployeeIds.isEmpty)
                const Text('Noch kein Personal zugeordnet',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 13,
                        fontWeight: FontWeight.bold))
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: job.assignedEmployeeIds.map((id) {
                    final employee = allEmployees
                        .where((e) => e.id == id)
                        .firstOrNull;
                    return _buildEmployeeChip(
                        employee?.name ?? id, employee?.status);
                  }).toList(),
                ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () =>
                    _showAssignEmployeesSheet(context, job, allEmployees, ref),
                icon: const Icon(Symbols.group_add, size: 18),
                label: const Text('PERSONAL ZUWEISEN'),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      AppColors.primaryContainer.withOpacity(0.05),
                  foregroundColor: AppColors.primaryContainer,
                  side: const BorderSide(color: AppColors.primaryContainer),
                ),
              ),
            ]),
            const SizedBox(height: 32),
            _buildSection('Notizen', [
              Text(
                job.notes ?? 'Keine zusätzlichen Notizen vorhanden.',
                style: TextStyle(
                    height: 1.5, color: Colors.black.withOpacity(0.7)),
              ),
            ]),
            const SizedBox(height: 48),
            _buildActionButtons(context, job, ref),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  void _showAssignEmployeesSheet(BuildContext context, Job job,
      List<Employee> allEmployees, WidgetRef ref) {
    final availableEmployees = allEmployees
        .where((e) =>
            e.status == EmployeeStatus.available ||
            e.status == EmployeeStatus.onDuty)
        .toList();

    final alreadyAssigned = Set<String>.from(job.assignedEmployeeIds);
    final selected = Set<String>.from(job.assignedEmployeeIds);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Personal zuweisen',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.navyDeep),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Verfügbare & aktive Mitarbeiter',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black.withOpacity(0.5)),
                  ),
                  const SizedBox(height: 20),
                  if (availableEmployees.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                          child: Text('Keine verfügbaren Mitarbeiter.')),
                    )
                  else
                    ...availableEmployees.map((emp) {
                      final isChecked = selected.contains(emp.id);
                      return CheckboxListTile(
                        value: isChecked,
                        onChanged: (val) {
                          setSheetState(() {
                            if (val == true) {
                              selected.add(emp.id);
                            } else {
                              selected.remove(emp.id);
                            }
                          });
                        },
                        title: Text(emp.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.navyDeep)),
                        subtitle: Text(emp.role,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.5))),
                        secondary: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.card1,
                            borderRadius: BorderRadius.circular(10),
                            image: emp.avatarUrl != null
                                ? DecorationImage(
                                    image: NetworkImage(emp.avatarUrl!),
                                    fit: BoxFit.cover)
                                : null,
                          ),
                          child: emp.avatarUrl == null
                              ? const Icon(Symbols.person,
                                  color: AppColors.primaryContainer, size: 20)
                              : null,
                        ),
                        activeColor: AppColors.primaryContainer,
                        contentPadding: EdgeInsets.zero,
                      );
                    }),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.navyDeep,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: () {
                        final newIds = selected
                            .where((id) => !alreadyAssigned.contains(id))
                            .toList();
                        if (newIds.isNotEmpty) {
                          ref
                              .read(jobRepositoryProvider.notifier)
                              .assignEmployees(job.id, newIds);
                        }
                        Navigator.of(ctx).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '${selected.length} Mitarbeiter zugewiesen.'),
                            backgroundColor: AppColors.navyDeep,
                          ),
                        );
                      },
                      child: const Text(
                        'ZUWEISUNG SPEICHERN',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStatusHeader(Job job) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                job.title,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.navyDeep),
              ),
              const SizedBox(height: 8),
              StatusChip.job(job.status.name),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.primaryContainer.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child:
              const Icon(Symbols.security, color: AppColors.primaryContainer),
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
              color: Colors.black.withOpacity(0.4)),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.slate),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.black.withOpacity(0.4))),
              Text(value,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeChip(String name, EmployeeStatus? status) {
    final statusColor = switch (status) {
      EmployeeStatus.onDuty => AppColors.primaryContainer,
      EmployeeStatus.available => Colors.green,
      EmployeeStatus.onBreak => Colors.orange,
      _ => Colors.grey,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.black.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
                color: statusColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(name,
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, Job job, WidgetRef ref) {
    final bool isInProgress = job.status == JobStatus.inProgress;
    return Column(
      children: [
        if (job.status == JobStatus.open)
          ElevatedButton(
            onPressed: () {
              ref
                  .read(jobRepositoryProvider.notifier)
                  .updateJobStatus(job.id, JobStatus.inProgress);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Dienst gestartet — Check-in erfolgreich.'),
                backgroundColor: AppColors.navyDeep,
              ));
            },
            child: const Text('DIENST STARTEN (CHECK-IN)'),
          )
        else if (isInProgress)
          ElevatedButton(
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: const Text('Dienst beenden?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.navyDeep)),
                  content: const Text(
                    'Der Dienst wird als abgeschlossen markiert. Diese Aktion kann nicht rückgängig gemacht werden.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(false),
                      child: const Text('ABBRECHEN'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.onSurface),
                      onPressed: () => Navigator.of(ctx).pop(true),
                      child: const Text('BEENDEN',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
              if (confirmed == true && context.mounted) {
                ref
                    .read(jobRepositoryProvider.notifier)
                    .updateJobStatus(job.id, JobStatus.completed);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Dienst beendet — Check-out erfolgreich.'),
                  backgroundColor: AppColors.navyDeep,
                ));
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.onSurface),
            child: const Text('DIENST BEENDEN (CHECK-OUT)'),
          ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () => context.push('/reports/create?jobId=${job.id}'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            side: const BorderSide(color: AppColors.navyDeep),
          ),
          child: const Text('BERICHT VERFASSEN'),
        ),
      ],
    );
  }
}
