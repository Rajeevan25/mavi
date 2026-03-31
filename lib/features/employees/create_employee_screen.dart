import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/discard_guard.dart';
import '../../data/models/employee.dart';
import '../../data/repositories/employee_repository.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

class CreateEmployeeScreen extends ConsumerStatefulWidget {
  const CreateEmployeeScreen({super.key});

  @override
  ConsumerState<CreateEmployeeScreen> createState() =>
      _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends ConsumerState<CreateEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _idNumberController = TextEditingController();
  String _role = 'Sicherheitsmitarbeiter/in';
  String _uniformSize = 'M';
  bool _weaponsPermit = false;
  List<String> _selectedCertifications = [];
  List<String> _selectedDriverClasses = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _idNumberController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final id = _nameController.text.trim().toLowerCase().replaceAll(' ', '_');
    final newEmployee = Employee(
      id: 'e_${DateTime.now().millisecondsSinceEpoch}',
      name: _nameController.text.trim(),
      role: _role,
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      availability: 'Nach Vereinbarung',
      idNumber: _idNumberController.text.trim().isEmpty
          ? null
          : _idNumberController.text.trim(),
      certifications: _selectedCertifications,
      driverLicenseClasses: _selectedDriverClasses,
      weaponsPermit: _weaponsPermit,
      uniformSize: _uniformSize,
      avatarUrl:
          'https://ui-avatars.com/api/?name=${Uri.encodeComponent(_nameController.text.trim())}&background=00234B&color=fff',
      status: EmployeeStatus.available,
    );

    ref.read(employeeRepositoryProvider.notifier).addEmployee(newEmployee);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mitarbeiter erfolgreich angelegt.'),
        backgroundColor: AppColors.navyDeep,
      ),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return DiscardGuard(
      hasChanges: () =>
          _nameController.text.isNotEmpty ||
          _phoneController.text.isNotEmpty ||
          _emailController.text.isNotEmpty,
      child: Scaffold(
      backgroundColor: AppColors.backgroundAlt,
      appBar: AppBar(title: const Text('Neuer Mitarbeiter')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('PERSÖNLICHE DATEN'),
              _buildTextField(
                controller: _nameController,
                label: 'Vollständiger Name',
                icon: Symbols.person,
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Pflichtfeld' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _phoneController,
                label: 'Telefonnummer (z.B. +41 71 123 45 67)',
                icon: Symbols.phone,
                keyboardType: TextInputType.phone,
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Pflichtfeld' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                label: 'E-Mail Adresse',
                icon: Symbols.mail,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) return 'Pflichtfeld';
                  if (!val.contains('@')) return 'Ungültige E-Mail-Adresse';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _idNumberController,
                label: 'Personalnummer / ID',
                icon: Symbols.badge,
              ),
              const SizedBox(height: 32),

              _buildSectionTitle('FUNKTION & UNIFORM'),
              _buildDropdown(
                'Rolle/Funktion',
                _role,
                [
                  'Einsatzleiter/in',
                  'Sicherheitsmitarbeiter/in',
                  'Hundeführer/in',
                  'Objektschutz',
                  'Interventionsfahrer/in',
                  'Ladenüberwachung',
                ],
                (val) => setState(() => _role = val!),
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                'Uniformgrösse',
                _uniformSize,
                ['S', 'M', 'L', 'XL', 'XXL'],
                (val) => setState(() => _uniformSize = val!),
              ),
              const SizedBox(height: 32),

              _buildSectionTitle('QUALIFIKATIONEN'),
              _buildMultiSelect(
                'Zertifizierungen',
                [
                  'Gepr. Schutz u. Sicherheit',
                  'Waffensachkunde §7',
                  'BLS-AED (Erste Hilfe)',
                  'Brandschutzhelfer',
                  'VSSU Basisprüfung',
                  'Personenschutz Spezialisierung',
                ],
                _selectedCertifications,
                (val) => setState(() => _selectedCertifications = val),
              ),
              const SizedBox(height: 16),
              _buildMultiSelect(
                'Führerausweis Kategorien',
                ['A', 'B', 'C1', 'D', 'BE'],
                _selectedDriverClasses,
                (val) => setState(() => _selectedDriverClasses = val),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Waffentragbewilligung vorhanden?'),
                  const Spacer(),
                  Switch(
                    value: _weaponsPermit,
                    onChanged: (val) => setState(() => _weaponsPermit = val),
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
                          'ERSTELLEN & SPEICHERN',
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

  Widget _buildDropdown(String label, String value, List<String> items,
      Function(String?) onChanged) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DropdownMenu<String>(
          initialSelection: value,
          label: Text(label),
          width: constraints.maxWidth,
          dropdownMenuEntries:
              items.map((i) => DropdownMenuEntry(value: i, label: i)).toList(),
          onSelected: onChanged,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        );
      },
    );
  }

  Widget _buildMultiSelect(String label, List<String> options,
      List<String> selected, Function(List<String>) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((opt) {
            final isSelected = selected.contains(opt);
            return GestureDetector(
              onTap: () {
                final newList = List<String>.from(selected);
                if (isSelected) {
                  newList.remove(opt);
                } else {
                  newList.add(opt);
                }
                onChanged(newList);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryContainer
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: isSelected
                          ? AppColors.primaryContainer
                          : Colors.grey.withOpacity(0.3)),
                ),
                child: Text(
                  opt,
                  style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white : Colors.black),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
