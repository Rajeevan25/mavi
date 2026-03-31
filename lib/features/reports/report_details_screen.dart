import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/date_utils.dart';
import '../../data/models/report.dart';
import '../../data/repositories/job_repository.dart';
import '../../data/repositories/report_repository.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

class ReportDetailsScreen extends ConsumerWidget {
  final String reportId;
  const ReportDetailsScreen({required this.reportId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reports = ref.watch(reportRepositoryProvider);
    final report = reports.where((r) => r.id == reportId).firstOrNull;
    if (report == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Berichtsdetails')),
        body: const Center(
          child: Text('Bericht nicht gefunden.',
              style: TextStyle(color: Colors.grey)),
        ),
      );
    }
    final job = ref.watch(jobByIdProvider(report.jobId));

    return Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(
        title: const Text('Berichtsdetails'),
        actions: [
          if (report.exportedPdf != null)
            IconButton(
              onPressed: () {
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PDF wird exportiert...')));
              },
              icon: const Icon(Symbols.picture_as_pdf),
            ),
           IconButton(
            onPressed: () {
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bericht geteilt.')));
            },
            icon: const Icon(Symbols.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusHeader(report),
            const SizedBox(height: 24),
            _buildSectionTitle('ALLGEMEINE INFORMATIONEN'),
            _buildInfoCard([
              _buildInfoRow(Symbols.work, 'Auftrag', job?.title ?? 'Unbekannt'),
              _buildInfoRow(Symbols.location_on, 'Standort', report.location),
              _buildInfoRow(Symbols.calendar_today, 'Datum', AppDateUtils.formatDate(report.date)),
              _buildInfoRow(Symbols.schedule, 'Zeitraum', '${report.workStart} - ${report.workEnd}'),
              if (report.weather != null)
                _buildInfoRow(Symbols.cloud, 'Wetter', report.weather!),
            ]),
            const SizedBox(height: 32),
            _buildSectionTitle('BERICHTSTYP & DETAILS'),
            _buildInfoCard([
              _buildInfoRow(Symbols.description, 'Typ', report.reportType),
              if (report.isIncident)
                _buildInfoRow(Symbols.warning, 'Vorgang', 'VORFALL / INCIDENT', color: Colors.red),
              if (report.policeNotified)
                _buildInfoRow(Symbols.local_police, 'Polizei', 'Informiert', color: Colors.blue),
            ]),
            const SizedBox(height: 32),
            _buildSectionTitle('TÄTIGKEITSBESCHREIBUNG'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black.withOpacity(0.05)),
              ),
              child: Text(
                report.notes,
                style: const TextStyle(fontSize: 15, height: 1.5, color: AppColors.textGreyDark),
              ),
            ),
            const SizedBox(height: 32),
            if (report.photoUrls.isNotEmpty) ...[
              _buildSectionTitle('FOTOS'),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: report.photoUrls.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 120,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(report.photoUrls[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
            ],
            _buildSectionTitle('UNTERSCHRIFT'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black.withOpacity(0.05)),
              ),
              child: Column(
                children: [
                  if (report.signatureUrl != null)
                    Image.network(report.signatureUrl!, height: 100)
                  else
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text('Digital unterschrieben', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
                    ),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    report.signedBy,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Text('Verantwortlicher Mitarbeiter', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusHeader(Report report) {
    final color = report.isIncident 
        ? (report.severity == 'high' ? Colors.red : Colors.orange) 
        : AppColors.primaryContainer;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(report.isIncident ? Symbols.warning : Symbols.check_circle, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            report.isIncident ? 'VORFALL GEMELDET' : 'REGULÄRER BERICHT',
            style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w900,
          color: Colors.grey,
          letterSpacing: 1.2,
        ),
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: color ?? AppColors.textGreyDark,
            ),
          ),
        ],
      ),
    );
  }
}
