import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/discard_guard.dart';
import '../../core/widgets/mavi_logo.dart';
import '../../data/models/report.dart';
import '../../data/repositories/report_repository.dart';
import '../../data/repositories/job_repository.dart';
import '../../data/repositories/employee_repository.dart';
import '../../core/providers/auth_provider.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reports = ref.watch(reportRepositoryProvider);
    final role = ref.watch(authProvider);
    final isEmployee = role == UserRole.employee;

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
      floatingActionButton: isEmployee
          ? FloatingActionButton.extended(
              heroTag: 'reports_fab',
              onPressed: () => context.push('/reports/create'),
              label: const Text('NEUER BERICHT',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.white)),
              icon: const Icon(Symbols.add, color: Colors.white),
              backgroundColor: AppColors.navyDeep,
            )
          : null,
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
  final _clientAddressController = TextEditingController();
  String? _selectedJobId;
  String _reportNumber = '2024-0158';
  String _reportType = 'Incident';
  DateTime _reportDate = DateTime.now();
  bool _isSigned = false;

  final List<GuardEntry> _guards = [
    const GuardEntry(
      name: 'Thomas Keller',
      startTime: '18:00',
      endTime: '02:00',
      pause: '00:30',
      total: '7:30',
    ),
    const GuardEntry(
      name: 'Julia Meier',
      startTime: '18:00',
      endTime: '02:00',
      pause: '00:30',
      total: '7:30',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _selectedJobId = widget.jobId;
    _clientAddressController.text = 'Hauptstrasse 12, 8001 Zürich';
  }

  @override
  void dispose() {
    _notesController.dispose();
    _clientAddressController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final newReport = Report(
      id: 'r_${DateTime.now().millisecondsSinceEpoch}',
      reportNumber: _reportNumber,
      jobId: _selectedJobId ?? 'unknown',
      location: _clientAddressController.text,
      clientAddress: _clientAddressController.text,
      date: _reportDate,
      workStart: '18:00',
      workEnd: '02:00',
      notes: _notesController.text,
      reportType: _reportType,
      isIncident: true,
      signedBy: 'M. Muster',
      guards: _guards,
      signatureUrl: _isSigned ? 'mock_signature_url' : null,
    );

    ref.read(reportRepositoryProvider.notifier).addReport(newReport);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Report saved successfully.'),
        backgroundColor: AppColors.navyDeep,
      ),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return DiscardGuard(
      hasChanges: () => _notesController.text.isNotEmpty || _isSigned,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _buildSliverHeader(),
            SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTitleSection(),
                    _buildIncidentDetails(),
                    _buildSectionHeader('Client'),
                    _buildClientDetails(),
                    _buildSectionHeader('Guards'),
                    _buildGuardsList(),
                    _buildSectionHeader('Incident Photos', icon: Symbols.photo_camera),
                    _buildPhotosSection(),
                    _buildSectionHeader('Notes'),
                    _buildNotesSection(),
                    _buildSignatureSection(),
                    _buildActionButtons(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverHeader() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: AppColors.navyDeep,
      iconTheme: const IconThemeData(color: Colors.white),
      leading: IconButton(
        icon: const Icon(Symbols.arrow_back),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/brand_header.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.navyDeep,
                child: const Center(
                  child: Icon(Symbols.broken_image, color: Colors.white24, size: 40),
                ),
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black26, Colors.transparent, Colors.black45],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        'INCIDENT REPORT',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w900,
          color: AppColors.navyDeep.withOpacity(0.8),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildIncidentDetails() {
    final dateFormat = DateFormat('dd.MM.yyyy');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          children: [
            _buildDetailRow(Symbols.calendar_today, 'Date:', dateFormat.format(_reportDate), true),
            _buildDetailRow(Symbols.location_on, 'Report No.:', _reportNumber, false),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, bool showDivider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: showDivider ? const Border(bottom: BorderSide(color: Colors.black12)) : null,
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),
          const SizedBox(width: 8),
          Text(value, style: const TextStyle(fontSize: 15, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {IconData? icon}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 30, bottom: 12, left: 20, right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFC5D5F0), // Matches mockup
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: AppColors.navyDeep),
            const SizedBox(width: 8),
          ],
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: AppColors.navyDeep,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: _clientAddressController,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.backgroundAlt,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildGuardsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundAlt,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: _guards.map((g) => _buildGuardItem(g)).toList(),
        ),
      ),
    );
  }

  Widget _buildGuardItem(GuardEntry guard) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              guard.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${guard.startTime} - ${guard.endTime} | Pause: ${guard.pause} | Total:',
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                  textAlign: TextAlign.right,
                ),
                Text(
                  guard.total,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotosSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // 3 items with 2 gaps of 8px each
          final itemWidth = (constraints.maxWidth - 16) / 3;
          final itemHeight = itemWidth; // square aspect
          return Row(
            children: [
              _buildPhotoThumb(
                'https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?q=80&w=400&auto=format&fit=crop',
                itemWidth, itemHeight,
              ),
              const SizedBox(width: 8),
              _buildPhotoThumb(
                'https://images.unsplash.com/photo-1587560699334-cc4ff634909a?q=80&w=400&auto=format&fit=crop',
                itemWidth, itemHeight,
              ),
              const SizedBox(width: 8),
              _buildAddPhotoButton(itemWidth, itemHeight),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPhotoThumb(String url, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildAddPhotoButton(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.backgroundAlt,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Symbols.add, color: AppColors.navyDeep.withOpacity(0.5)),
          Text('Add', style: TextStyle(fontSize: 10, color: AppColors.navyDeep.withOpacity(0.5))),
          Text('Photo', style: TextStyle(fontSize: 10, color: AppColors.navyDeep.withOpacity(0.5))),
        ],
      ),
    );
  }

  Widget _buildNotesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: _notesController,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: 'Add note...',
          filled: true,
          fillColor: AppColors.backgroundAlt,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSignatureSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Client Signature', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => setState(() => _isSigned = !_isSigned),
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.1), width: 1)),
              ),
              child: _isSigned 
                ? Center(
                    child: Text(
                      'M. Muster',
                      style: TextStyle(
                        fontFamily: 'DancingScript', // Assuming a handwritten font is available or fallback
                        fontSize: 32,
                        color: AppColors.navyDeep,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                : Center(child: Text('Tap to sign', style: TextStyle(color: Colors.black.withOpacity(0.2)))),
            ),
          ),
          const SizedBox(height: 8),
          Text('Firma Mustermann GmbH', style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5))),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              'Cancel', 
              Colors.red[700]!, 
              Symbols.close, 
              () => context.pop()
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildActionButton(
              'Save', 
              AppColors.navyDeep, 
              Symbols.check_circle, 
              _submit
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, Color color, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
