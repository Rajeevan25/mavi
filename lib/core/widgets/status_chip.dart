import 'package:flutter/material.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

class StatusChip extends StatelessWidget {
  final String label;
  final Color color;
  final Color? textColor;

  const StatusChip({
    required this.label,
    required this.color,
    this.textColor,
    super.key,
  });

  factory StatusChip.job(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return const StatusChip(label: 'OFFEN', color: AppColors.neutral100);
      case 'in_progress':
      case 'inprogres':
        return const StatusChip(
          label: 'AKTIV',
          color: AppColors.primaryContainer,
          textColor: Colors.white,
        );
      case 'completed':
        return const StatusChip(
          label: 'ERLEDIGT',
          color: AppColors.neutral200,
        );
      default:
        return StatusChip(label: status.toUpperCase(), color: Colors.grey);
    }
  }

  factory StatusChip.employee(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return const StatusChip(
          label: 'VERFÜGBAR',
          color: AppColors.successLight,
          textColor: Colors.green,
        );
      case 'on_duty':
        return const StatusChip(
          label: 'IM DIENST',
          color: AppColors.primaryContainer,
          textColor: Colors.white,
        );
      case 'on_break':
        return const StatusChip(
          label: 'PAUSE',
          color: AppColors.warningLight,
          textColor: Colors.orange,
        );
      case 'unavailable':
        return const StatusChip(
          label: 'NICHT VERFÜGBAR',
          color: AppColors.errorLight,
          textColor: Colors.red,
        );
      default:
        return StatusChip(label: status.toUpperCase(), color: Colors.grey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor ?? AppColors.onSurface,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
