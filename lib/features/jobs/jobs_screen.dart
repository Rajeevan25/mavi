import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/job.dart';
import '../../data/repositories/job_repository.dart';
import '../../core/widgets/skeleton_loader.dart';
import 'job_card.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

class JobsScreen extends ConsumerStatefulWidget {
  const JobsScreen({super.key});

  @override
  ConsumerState<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends ConsumerState<JobsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _filter = 'Alle';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final jobs = ref.watch(jobRepositoryProvider);
    final counts = {
      'Alle': jobs.length,
      'Offen': jobs.where((j) => j.status == JobStatus.open).length,
      'Aktiv': jobs.where((j) => j.status == JobStatus.inProgress).length,
      'Erledigt': jobs.where((j) => j.status == JobStatus.completed).length,
    };
    final filteredJobs = jobs.where((job) {
      final matchesSearch = job.title.toLowerCase().contains(_searchController.text.toLowerCase()) ||
          job.location.toLowerCase().contains(_searchController.text.toLowerCase());
      final matchesFilter = _filter == 'Alle' ||
          (_filter == 'Offen' && job.status == JobStatus.open) ||
          (_filter == 'Aktiv' && job.status == JobStatus.inProgress) ||
          (_filter == 'Erledigt' && job.status == JobStatus.completed);
      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Auftragsübersicht'),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Filteroptionen werden geladen...')));
            },
            icon: const Icon(Symbols.filter_list),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Suchen nach Auftrag, Ort...',
                prefixIcon: const Icon(Symbols.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: ['Alle', 'Offen', 'Aktiv', 'Erledigt'].map((filter) {
                final isSelected = _filter == filter;
                final count = counts[filter] ?? 0;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text('$filter ($count)'),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _filter = filter),
                    backgroundColor: Colors.white,
                    selectedColor: AppColors.primaryContainer,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.primaryContainer,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(
                        color: isSelected
                            ? Colors.transparent
                            : AppColors.primaryContainer.withOpacity(0.1),
                      ),
                    ),
                    showCheckmark: false,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _isLoading 
                ? ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: 4,
                    itemBuilder: (context, index) => const JobCardSkeletonLoader(),
                  )
                : filteredJobs.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredJobs.length,
                        itemBuilder: (context, index) {
                          final job = filteredJobs[index];
                          return JobCard(
                            job: job,
                            onTap: () {
                              context.push('/jobs/${job.id}');
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/jobs/create');
        },
        backgroundColor: AppColors.navyDeep,
        child: const Icon(Symbols.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Symbols.search_off, size: 64, color: Colors.black.withOpacity(0.1)),
          const SizedBox(height: 16),
          Text(
            'Keine Aufträge gefunden',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
