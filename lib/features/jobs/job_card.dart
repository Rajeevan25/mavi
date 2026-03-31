import 'package:flutter/material.dart';
import '../../data/models/job.dart';
import '../../core/widgets/status_chip.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;

  const JobCard({
    required this.job,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatusChip.job(job.status.name),
                  Text(
                    'ID: ${job.id.toUpperCase()}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                job.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.navyDeep,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                   Icon(Symbols.location_on, size: 14, color: Colors.black.withOpacity(0.4)),
                   const SizedBox(width: 4),
                   Expanded(
                     child: Text(
                        job.location,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black.withOpacity(0.5),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                   ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildIconText(Symbols.calendar_today, _formatDate(job.date)),
                  const SizedBox(width: 16),
                  _buildIconText(Symbols.schedule, '${job.startTime} - ${job.endTime}'),
                   const Spacer(),
                   const Icon(Symbols.chevron_right, size: 20, color: AppColors.navyDeep),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.primaryContainer),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryContainer,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (DateUtils.isSameDay(date, now)) return 'Heute';
    if (DateUtils.isSameDay(date, now.add(const Duration(days: 1)))) return 'Morgen';
    return '${date.day}.${date.month}.${date.year}';
  }
}
