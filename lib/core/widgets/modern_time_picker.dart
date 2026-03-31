import 'package:flutter/material.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

class ModernTimePicker extends StatelessWidget {
  final String label;
  final IconData icon;
  final TimeOfDay? selectedTime;
  final Function(TimeOfDay) onTimeSelected;

  const ModernTimePicker({
    required this.label,
    required this.icon,
    this.selectedTime,
    required this.onTimeSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final displayTime = selectedTime != null
        ? '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}'
        : '';

     return TextFormField(
      key: ValueKey(displayTime),
      initialValue: displayTime,
      readOnly: true,
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: selectedTime ?? TimeOfDay.now(),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.primaryContainer,
                  onPrimary: Colors.white,
                  onSurface: AppColors.navyDeep,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          onTimeSelected(picked);
        }
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
    );
  }
}
