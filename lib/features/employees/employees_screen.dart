import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/employee.dart';
import '../../data/repositories/employee_repository.dart';
import '../../core/widgets/status_chip.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

class EmployeesScreen extends ConsumerWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employees = ref.watch(employeeRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personalverwaltung'),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Personensuche wird geladen...')));
            },
            icon: const Icon(Symbols.search),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final employee = employees[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              leading: _buildAvatar(employee),
              title: Text(employee.name, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.navyDeep)),
              subtitle: Text(employee.role, style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5))),
              trailing: StatusChip.employee(employee.status.name),
              onTap: () => context.push('/employees/${employee.id}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'employees_fab',
        onPressed: () => context.push('/employees/create'),
        backgroundColor: AppColors.navyDeep,
        child: const Icon(Symbols.add, color: Colors.white),
      ),
    );
  }

  ImageProvider _resolveImage(String url) {
    if (url.startsWith('http')) return NetworkImage(url);
    return AssetImage(url);
  }

  Widget _buildAvatar(Employee employee) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.card1,
        borderRadius: BorderRadius.circular(12),
        image: employee.avatarUrl != null
          ? DecorationImage(
              image: _resolveImage(employee.avatarUrl!),
              fit: BoxFit.cover,
            )
          : null,
      ),
      child: employee.avatarUrl == null ? const Icon(Symbols.person, color: AppColors.primaryContainer) : null,
    );
  }
}
