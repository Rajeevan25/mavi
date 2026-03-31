import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/employee.dart';
import '../../data/repositories/employee_repository.dart';
import '../../core/widgets/status_chip.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

class EmployeeDetailsScreen extends ConsumerWidget {
  final String employeeId;
  const EmployeeDetailsScreen({required this.employeeId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employees = ref.watch(employeeRepositoryProvider);
    final employee = employees.firstWhere((e) => e.id == employeeId, orElse: () => throw Exception('Mitarbeiter nicht gefunden'));

    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, employee),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildQuickStats(employee),
                  const SizedBox(height: 32),
                  _buildSectionTitle('PERSÖNLICHE DATEN'),
                  _buildInfoCard([
                    _buildInfoRow(Symbols.badge, 'Personalnummer', employee.idNumber ?? 'Nicht hinterlegt'),
                    _buildInfoRow(Symbols.phone, 'Telefon', employee.phone),
                    _buildInfoRow(Symbols.mail, 'E-Mail', employee.email),
                    _buildInfoRow(Symbols.contact_emergency, 'Notfallkontakt', employee.emergencyContact ?? 'Nicht hinterlegt'),
                    _buildInfoRow(Symbols.check_circle, 'Verifiziert', employee.isVerified ? 'Ja' : 'Nein', color: employee.isVerified ? Colors.green : Colors.orange),
                  ]),
                  const SizedBox(height: 32),
                  _buildSectionTitle('QUALIFIKATIONEN & SKILLS'),
                  _buildSkillSection(employee),
                  const SizedBox(height: 32),
                  _buildSectionTitle('DOKUMENTE & FREIGABEN'),
                  _buildInfoCard([
                    _buildInfoRow(Symbols.directions_car, 'Führerausweis', employee.driverLicenseClasses.isEmpty ? 'Keiner' : employee.driverLicenseClasses.join(', ')),
                    _buildInfoRow(Symbols.security, 'Leumundsprüfung', employee.criminalRecordDate != null ? '${employee.criminalRecordDate!.day}.${employee.criminalRecordDate!.month}.${employee.criminalRecordDate!.year}' : 'Ausstehend', color: employee.criminalRecordDate != null ? Colors.green : Colors.red),
                    _buildInfoRow(Symbols.medical_services, 'Erste Hilfe bis', employee.firstAidExpiry != null ? '${employee.firstAidExpiry!.day}.${employee.firstAidExpiry!.month}.${employee.firstAidExpiry!.year}' : 'Nicht hinterlegt'),
                    _buildInfoRow(Symbols.vpn_key, 'Waffentragbewilligung', employee.weaponsPermit ? 'Vorhanden' : 'Nicht vorhanden', color: employee.weaponsPermit ? Colors.blue : Colors.grey),
                    _buildInfoRow(Symbols.apparel, 'Uniformgrösse', employee.uniformSize ?? 'Nicht hinterlegt'),
                  ]),
                  const SizedBox(height: 48),
                   SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () {
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Einsatzplanung wird geöffnet...')));
                      },
                      icon: const Icon(Symbols.calendar_add_on),
                      label: const Text('EINSATZ ZUWEISEN'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.navyDeep,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, Employee employee) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: AppColors.navyDeep,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (employee.avatarUrl != null)
              Image.network(employee.avatarUrl!, fit: BoxFit.cover)
            else
              Container(color: AppColors.primaryContainer, child: const Icon(Symbols.person, size: 80, color: Colors.white24)),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withOpacity(0.3), Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatusChip.employee(employee.status.name),
                  const SizedBox(height: 8),
                  Text(
                    employee.name,
                    style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    employee.role,
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats(Employee employee) {
    return Row(
      children: [
        Expanded(child: _buildStatItem('RATING', '${employee.rating}', Symbols.star, Colors.amber)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatItem('ERFAHRUNG', '${employee.experienceYears}J', Symbols.history, Colors.blue)),
        const SizedBox(width: 12),
        Expanded(child: _buildStatItem('SPRACHEN', '${employee.languages.length}', Symbols.language, Colors.green)),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: Colors.grey, letterSpacing: 1.2),
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color ?? AppColors.textGrey),
          const SizedBox(width: 16),
          Text(label, style: const TextStyle(color: AppColors.textGrey, fontSize: 14)),
          const Spacer(),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color ?? AppColors.textGreyDark),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillSection(Employee employee) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...employee.certifications.map((cert) => _buildChip(cert, AppColors.infoLight, Colors.blue)),
        ...employee.languages.map((lang) => _buildChip(lang, AppColors.successLight, Colors.green)),
      ],
    );
  }

  Widget _buildChip(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: text.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(color: text, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}
