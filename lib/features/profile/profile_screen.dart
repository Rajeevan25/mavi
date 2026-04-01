import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:mavi_security/core/providers/auth_provider.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil & Einstellungen')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primaryContainer,
              backgroundImage: const AssetImage('images/guard_male.png'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Markus Keller',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.navyDeep),
            ),
            const Text(
              'Einsatzleiter • MAVI Security AG',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            _buildProfileItem(Symbols.badge, 'Personalnummer', 'MAVI-2024-001'),
            _buildProfileItem(Symbols.email, 'E-Mail', 'm.keller@mavi.ch'),
            _buildProfileItem(Symbols.phone, 'Telefon', '+41 71 123 45 67'),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),
            _buildSettingItem(Symbols.settings, 'App-Einstellungen'),
            _buildSettingItem(Symbols.security, 'Sicherheit & Datenschutz'),
            _buildSettingItem(Symbols.help, 'Support & Hilfe'),
            const SizedBox(height: 32),
            TextButton.icon(
              onPressed: () {
                ref.read(authProvider.notifier).state = UserRole.guest;
                context.go('/login');
              },
              icon: const Icon(Symbols.logout, color: Colors.red),
              label: const Text('ABMELDEN', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.slate),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.primaryContainer),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      trailing: const Icon(Symbols.chevron_right),
      onTap: () {},
    );
  }
}
