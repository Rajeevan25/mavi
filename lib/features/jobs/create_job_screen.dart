import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/discard_guard.dart';
import '../../core/widgets/modern_date_picker.dart';
import '../../core/widgets/modern_time_picker.dart';
import '../../data/models/job.dart';
import '../../data/repositories/job_repository.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

class CreateJobScreen extends ConsumerStatefulWidget {
  const CreateJobScreen({super.key});

  @override
  ConsumerState<CreateJobScreen> createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends ConsumerState<CreateJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _serviceTypeController = TextEditingController();
  final _locationController = TextEditingController();
  final _clientNameController = TextEditingController();
  final _contactPhoneController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _serviceTypeController.dispose();
    _locationController.dispose();
    _clientNameController.dispose();
    _contactPhoneController.dispose();
    super.dispose();
  }

  String _formatTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte ein Datum auswählen.')),
      );
      return;
    }
    if (_startTime == null || _endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bitte Start- und Endzeit angeben.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulated network delay
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final newJob = Job(
      id: 'j_${DateTime.now().millisecondsSinceEpoch}',
      title: _titleController.text.trim(),
      serviceType: _serviceTypeController.text.trim(),
      location: _locationController.text.trim(),
      date: _selectedDate!,
      startTime: _formatTime(_startTime!),
      endTime: _formatTime(_endTime!),
      clientName: _clientNameController.text.trim().isEmpty
          ? null
          : _clientNameController.text.trim(),
      contactPhone: _contactPhoneController.text.trim().isEmpty
          ? null
          : _contactPhoneController.text.trim(),
      status: JobStatus.open,
    );

    ref.read(jobRepositoryProvider.notifier).addJob(newJob);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Auftrag erfolgreich angelegt.'),
        backgroundColor: AppColors.navyDeep,
      ),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return DiscardGuard(
      hasChanges: () =>
          _titleController.text.isNotEmpty ||
          _locationController.text.isNotEmpty ||
          _selectedDate != null,
      child: Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(title: const Text('Neuer Auftrag')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('AUFTRAGSDETAILS'),
              _buildTextField(
                controller: _titleController,
                label: 'Titel des Auftrags',
                icon: Symbols.title,
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Pflichtfeld' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _serviceTypeController,
                label: 'Dienstleistung (z.B. Objektschutz)',
                icon: Symbols.work,
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Pflichtfeld' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _locationController,
                label: 'Standort / Adresse',
                icon: Symbols.location_on,
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Pflichtfeld' : null,
              ),
              const SizedBox(height: 32),

              _buildSectionTitle('ZEITPLANUNG'),
              Row(
                children: [
                  Expanded(
                    child: ModernDatePicker(
                      label: 'Datum',
                      icon: Symbols.calendar_today,
                      selectedDate: _selectedDate,
                      onDateSelected: (date) =>
                          setState(() => _selectedDate = date),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ModernTimePicker(
                      label: 'Startzeit',
                      icon: Symbols.schedule,
                      selectedTime: _startTime,
                      onTimeSelected: (time) =>
                          setState(() => _startTime = time),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ModernTimePicker(
                      label: 'Endzeit',
                      icon: Symbols.schedule,
                      selectedTime: _endTime,
                      onTimeSelected: (time) =>
                          setState(() => _endTime = time),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              _buildSectionTitle('KUNDE'),
              _buildTextField(
                controller: _clientNameController,
                label: 'Kundenname',
                icon: Symbols.person,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _contactPhoneController,
                label: 'Kontakttelefon',
                icon: Symbols.phone,
                keyboardType: TextInputType.phone,
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
                  onPressed: _isLoading ? null : _submit,
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'AUFTRAG SPEICHERN',
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error)),
      ),
    );
  }
}
