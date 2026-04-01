import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:intl/intl.dart';
import '../../core/utils/date_utils.dart';
import '../../core/widgets/mavi_logo.dart';
import '../../data/models/report.dart';
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
        appBar: AppBar(title: const Text('Report Details')),
        body: const Center(child: Text('Report not found.')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildSliverHeader(),
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 600),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPdfTitle(report),
                    const SizedBox(height: 24),
                    _buildDateAndReportNo(report),
                    const SizedBox(height: 30),
                    _buildPdfSectionHeader('Client'),
                    _buildClientAddress(report),
                    const SizedBox(height: 24),
                    _buildPdfSectionHeader('Guards'),
                    _buildPdfGuardsTable(report.guards),
                    const SizedBox(height: 40),
                    _buildPdfSignature(report),
                    const SizedBox(height: 100), // Spacing for bottom
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverHeader() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: AppColors.navyDeep,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Symbols.picture_as_pdf, color: Colors.white),
        ),
      ],
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
            // Shadow overlay for better readability
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

  Widget _buildPdfTitle(Report report) {
    return const Center(
      child: Text(
        'INCIDENT REPORT',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w900,
          color: Colors.black87,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildDateAndReportNo(Report report) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          _buildInfoRow(Symbols.calendar_today, 'Date:', DateFormat('dd.MM.yyyy').format(report.date), true),
          _buildInfoRow(Symbols.location_on, 'Report No.:', report.reportNumber, false),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, bool showDivider) {
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

  Widget _buildClientAddress(Report report) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Text(
        report.clientAddress.isEmpty ? report.location : report.clientAddress,
        style: const TextStyle(fontSize: 16, height: 1.5, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildPdfSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          color: AppColors.navyDeep,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildPdfSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFC5D5F0), // Matching light blue from mockup
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          color: AppColors.navyDeep,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildPdfTable(List<Widget> rows) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(children: rows),
    );
  }

  Widget _buildPdfTableRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 100, child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }

  Widget _buildPdfGuardsTable(List<GuardEntry> guards) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        children: guards.map((g) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 4,
                child: Text(g.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15))
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('${g.startTime} - ${g.endTime} | Pause: ${g.pause} | Total:', 
                      style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    Text(g.total, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildPdfPhotos(Report report) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // 2 photos with 1 gap of 10px
          final itemWidth = (constraints.maxWidth - 10) / 2;
          final itemHeight = itemWidth * 0.65; // ~2:3 landscape aspect ratio
          return Row(
            children: [
              _buildPdfPhotoThumb(
                'https://images.unsplash.com/photo-1582268611958-ebfd161ef9cf?q=80&w=600&auto=format&fit=crop',
                itemWidth, itemHeight,
              ),
              const SizedBox(width: 10),
              _buildPdfPhotoThumb(
                'https://images.unsplash.com/photo-1563986768609-322da13575f3?q=80&w=600&auto=format&fit=crop',
                itemWidth, itemHeight,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPdfPhotoThumb(String url, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: Colors.black12),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildPdfSignature(Report report) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Client Signature', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        const Text(
          'M. Muster',
          style: TextStyle(
            fontSize: 32,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w300,
            color: Colors.black87,
          ),
        ),
        Container(
          width: 250,
          margin: const EdgeInsets.only(top: 8),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black45)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(report.signedBy, style: const TextStyle(fontSize: 11)),
          ),
        ),
      ],
    );
  }

  Widget _buildPdfFooter() {
    return Row(
      children: [
        // Simulated QR Code
        Container(
          width: 60,
          height: 60,
          color: Colors.black,
          child: const Icon(Symbols.qr_code, color: Colors.white, size: 40),
        ),
        const SizedBox(width: 20),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hauptstrasse 45, 8000 Zürich - UID: CHE-123.456.789', style: TextStyle(fontSize: 10, color: Colors.grey)),
              Text('TEL: +41 44 125 45 67 - www.mavi-security.ch', style: TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}
