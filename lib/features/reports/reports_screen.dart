import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/discard_guard.dart';
import '../../data/models/report.dart';
import '../../data/repositories/report_repository.dart';
import '../../data/repositories/job_repository.dart';
import '../../data/repositories/employee_repository.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reports = ref.watch(reportRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Berichtsübersicht'),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Filteroptionen werden geladen...')));
            },
            icon: const Icon(Symbols.filter_alt),
          ),
        ],
      ),
      body: reports.isEmpty
          ? const Center(child: Text('Keine Berichte vorhanden'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final report = reports[index];
                return _buildReportCard(context, report, ref);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/reports/create'),
        label: const Text('NEUER BERICHT',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.white)),
        icon: const Icon(Symbols.add, color: Colors.white),
        backgroundColor: AppColors.navyDeep,
      ),
    );
  }

  Widget _buildReportCard(BuildContext context, Report report, WidgetRef ref) {
    final job = ref.watch(jobByIdProvider(report.jobId));
    final color = report.isIncident ? Colors.red[700] : AppColors.primaryContainer;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
              report.isIncident ? Symbols.warning : Symbols.description,
              color: color),
        ),
        title: Text(
          job?.title ?? 'Unbekannter Auftrag',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: AppColors.navyDeep),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${AppDateUtils.formatDate(report.date)} • ${report.reportType}',
              style: TextStyle(
                  fontSize: 12, color: Colors.black.withOpacity(0.5)),
            ),
          ],
        ),
        trailing: report.exportedPdf != null
            ? IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('PDF-Export wurde simuliert.')));
                },
                icon: const Icon(Symbols.file_download,
                    color: AppColors.primaryContainer),
              )
            : const Icon(Symbols.chevron_right,
                size: 20, color: AppColors.navyDeep),
        onTap: () => context.push('/reports/${report.id}'),
      ),
    );
  }
}

class CreateReportScreen extends ConsumerStatefulWidget {
  final String? jobId;
  const CreateReportScreen({this.jobId, super.key});

  @override
  ConsumerState<CreateReportScreen> createState() =>
      _CreateReportScreenState();
}

class _CreateReportScreenState extends ConsumerState<CreateReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  final _startController = TextEditingController();
  final _endController = TextEditingController();
  String? _selectedJobId;
  String _reportType = 'Routine';
  String _severity = 'low';
  bool _isIncident = false;
  String? _weather = 'Sonnig';
  bool _policeNotified = false;
  bool _isSigned = false;

  @override
  void initState() {
    super.initState();
    _selectedJobId = widget.jobId;
    // Pre-fill times from selected job if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _prefillTimesFromJob();
    });
  }

  void _prefillTimesFromJob() {
    if (_selectedJobId == null) return;
    final jobs = ref.read(jobRepositoryProvider);
    try {
      final job = jobs.firstWhere((j) => j.id == _selectedJobId);
      _startController.text = job.startTime;
      _endController.text = job.endTime;
    } catch (_) {}
  }

  @override
  void dispose() {
    _notesController.dispose();
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }

  void _onJobChanged(String? jobId) {
    setState(() => _selectedJobId = jobId);
    if (jobId == null) return;
    final jobs = ref.read(jobRepositoryProvider);
    try {
      final job = jobs.firstWhere((j) => j.id == jobId);
      _startController.text = job.startTime;
      _endController.text = job.endTime;
    } catch (_) {}
  }

  void _submit() {
    if (_selectedJobId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte einen Auftrag auswählen.')),
      );
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    final jobs = ref.read(jobRepositoryProvider);
    final employees = ref.read(employeeRepositoryProvider);

    String location = '';
    try {
      location = jobs.firstWhere((j) => j.id == _selectedJobId).location;
    } catch (_) {}

    // Use the logged-in user's name (Markus Keller, hardcoded for demo)
    const signedBy = 'Markus Keller';

    final newReport = Report(
      id: 'r_${DateTime.now().millisecondsSinceEpoch}',
      jobId: _selectedJobId!,
      location: location,
      date: DateTime.now(),
      workStart: _startController.text.trim().isEmpty
          ? '00:00'
          : _startController.text.trim(),
      workEnd: _endController.text.trim().isEmpty
          ? '00:00'
          : _endController.text.trim(),
      notes: _notesController.text.trim(),
      reportType: _reportType,
      isIncident: _isIncident,
      severity: _isIncident ? _severity : 'low',
      weather: _weather,
      policeNotified: _isIncident && _policeNotified,
      signedBy: signedBy,
      signatureUrl: _isSigned
          ? 'https://ui-avatars.com/api/?name=M+Keller&background=eee&color=000&bold=true&size=100&length=2'
          : null,
    );

    ref.read(reportRepositoryProvider.notifier).addReport(newReport);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bericht erfolgreich gespeichert.'),
        backgroundColor: AppColors.navyDeep,
      ),
    );
    context.pop();
    context.push('/reports/${newReport.id}');
  }

  @override
  Widget build(BuildContext context) {
    final jobs = ref.watch(jobRepositoryProvider);

    return DiscardGuard(
      hasChanges: () =>
          _notesController.text.isNotEmpty || _selectedJobId != null,
      child: Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(title: const Text('Bericht erstellen')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('AUFTRAG AUSWÄHLEN'),
              DropdownButtonFormField<String>(
                isExpanded: true,
                value: _selectedJobId,
                hint: const Text('Auftrag auswählen...'),
                items: jobs
                    .map((job) => DropdownMenuItem(
                        value: job.id,
                        child: Text(
                          job.title,
                          overflow: TextOverflow.ellipsis,
                        )))
                    .toList(),
                onChanged: _onJobChanged,
                validator: (val) =>
                    val == null ? 'Bitte einen Auftrag auswählen' : null,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: AppColors.error)),
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('ZEITRAUM & WETTER'),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _startController,
                      decoration: InputDecoration(
                        labelText: 'Beginn',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none),
                      ),
                      validator: (val) =>
                          val == null || val.trim().isEmpty
                              ? 'Pflichtfeld'
                              : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _endController,
                      decoration: InputDecoration(
                        labelText: 'Ende',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none),
                      ),
                      validator: (val) =>
                          val == null || val.trim().isEmpty
                              ? 'Pflichtfeld'
                              : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                isExpanded: true,
                value: _weather,
                items: ['Sonnig', 'Bewölkt', 'Regnerisch', 'Schnee', 'Nebel']
                    .map((w) => DropdownMenuItem(
                        value: w,
                        child: Text(
                          w,
                          overflow: TextOverflow.ellipsis,
                        )))
                    .toList(),
                onChanged: (val) => setState(() => _weather = val),
                decoration: InputDecoration(
                  labelText: 'Wettersituation',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 32),
              _buildSectionTitle('BERICHTSTYP'),
              _buildReportTypeSelector(),
              if (_isIncident) ...[
                const SizedBox(height: 24),
                _buildIncidentSection(),
              ],
              const SizedBox(height: 32),
              _buildSectionTitle('TÄTIGKEITSBERICHT'),
              TextFormField(
                controller: _notesController,
                maxLines: 5,
                validator: (val) =>
                    val == null || val.trim().isEmpty
                        ? 'Bitte einen Bericht verfassen'
                        : null,
                decoration: InputDecoration(
                  hintText: 'Zusammenfassung der ausgeführten Arbeiten...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: AppColors.error)),
                ),
              ),
              const SizedBox(height: 32),
              _buildSectionTitle('FOTOS & SIGNATUR'),
              Row(
                children: [
                  _buildPhotoSquare(),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isSigned = !_isSigned),
                      child: Container(
                        height: 100,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _isSigned
                              ? Colors.green.withOpacity(0.1)
                              : Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: _isSigned
                                  ? Colors.green
                                  : Colors.black.withOpacity(0.1),
                              width: 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                                _isSigned
                                    ? Symbols.history_edu
                                    : Symbols.draw,
                                color:
                                    _isSigned ? Colors.green : Colors.grey),
                            const SizedBox(height: 4),
                            Text(
                              _isSigned
                                  ? 'Unterschrieben'
                                  : 'Unterschreiben',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: _isSigned
                                      ? Colors.green
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.navyDeep,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: _submit,
                  child: const Text(
                    'SPEICHERN & SENDEN',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    )); // DiscardGuard + Scaffold
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.0,
            color: Colors.grey),
      ),
    );
  }

  Widget _buildReportTypeSelector() {
    final types = [
      {'label': 'Routine', 'icon': Symbols.check_circle_outline},
      {'label': 'Vorfall', 'icon': Symbols.warning},
      {'label': 'Wartung', 'icon': Symbols.build},
      {'label': 'Alarm', 'icon': Symbols.notification_important},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: types.map((t) {
        final isSelected = _reportType == t['label'];
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _reportType = t['label'] as String;
                _isIncident =
                    _reportType == 'Vorfall' || _reportType == 'Alarm';
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryContainer
                    : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: isSelected
                        ? AppColors.primaryContainer
                        : Colors.black.withOpacity(0.05)),
              ),
              child: Column(
                children: [
                  Icon(t['icon'] as IconData,
                      color: isSelected ? Colors.white : Colors.grey,
                      size: 20),
                  const SizedBox(height: 4),
                  Text(
                    t['label'] as String,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color:
                            isSelected ? Colors.white : Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildIncidentSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('VORFALLS-DETAILS',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
          const SizedBox(height: 16),
          _buildPillSelector(
              'Priorität',
              ['Niedrig', 'Mittel', 'Hoch'],
              _severity,
              (val) => setState(() => _severity = val)),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Polizei informiert?',
                  style: TextStyle(fontSize: 14)),
              const Spacer(),
              Switch(
                  value: _policeNotified,
                  onChanged: (val) =>
                      setState(() => _policeNotified = val)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPillSelector(String label, List<String> options,
      String current, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 8),
        Row(
          children: options.map((opt) {
            final isSelected = current == opt.toLowerCase();
            return GestureDetector(
              onTap: () => onSelect(opt.toLowerCase()),
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.red : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: isSelected
                          ? Colors.red
                          : Colors.grey.withOpacity(0.3)),
                ),
                child: Text(
                  opt,
                  style: TextStyle(
                      fontSize: 12,
                      color:
                          isSelected ? Colors.white : Colors.black,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPhotoSquare() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kamera-Funktion wird in der finalen Version verfügbar sein.')),
        );
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: Colors.black.withOpacity(0.1),
              style: BorderStyle.solid),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Symbols.add_a_photo, color: Colors.grey),
            SizedBox(height: 4),
            Text('Foto',
                style: TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
