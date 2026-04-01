import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:mavi_security/core/theme/app_colors.dart';
import 'package:mavi_security/core/providers/auth_provider.dart';
import 'package:mavi_security/features/shift/shift_screen.dart';

class EmployeeDashboardScreen extends ConsumerStatefulWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  ConsumerState<EmployeeDashboardScreen> createState() => _EmployeeDashboardScreenState();
}

class _EmployeeDashboardScreenState extends ConsumerState<EmployeeDashboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 896), // max-w-4xl
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _buildMainActions(),
                const SizedBox(height: 32),
                _buildNextAssignment(),
                const SizedBox(height: 32),
                // Grid layout based on screen width
                _buildNotifications(),
                const SizedBox(height: 32),
                _buildTodayOverview(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final shiftStatus = ref.watch(shiftProvider).status;
    Color statusColor;
    String statusLabel;

    switch (shiftStatus) {
      case ShiftStatus.offDuty:
        statusColor = AppColors.slate;
        statusLabel = 'BEREIT';
        break;
      case ShiftStatus.onDuty:
        statusColor = AppColors.success;
        statusLabel = 'IM DIENST';
        break;
      case ShiftStatus.onBreak:
        statusColor = AppColors.warning;
        statusLabel = 'PAUSE';
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.push('/profile'),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.outlineVariant, width: 2),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 2))
                    ],
                    image: const DecorationImage(
                      image: AssetImage('assets/images/guard_male.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HANS MÜLLER',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.navyDeep,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      'ID 4402 • MAVI SECURITY',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.navyLight.withOpacity(0.8),
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Switch portal button
        Tooltip(
          message: 'Portal wechseln',
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              ref.read(authProvider.notifier).state = UserRole.guest;
              context.go('/login');
            },
            icon: const Icon(Symbols.switch_account, color: AppColors.primaryContainer, size: 22),
          ),
        ),
        const SizedBox(width: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            border: Border.all(color: statusColor.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FadeTransition(
                opacity: _pulseController,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: statusColor.withOpacity(0.5), blurRadius: 4, spreadRadius: 1)
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                statusLabel,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMainActions() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                title: 'Wochenstunden',
                value: '32.5h',
                icon: Symbols.history,
                iconColor: AppColors.primaryContainer,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                title: 'Wochenverdienst',
                value: '812.50 CHF',
                icon: Symbols.account_balance_wallet,
                iconColor: AppColors.success,
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildSecondaryAction(
                icon: Symbols.edit_document,
                label: 'Bericht schreiben',
                onTap: () => context.push('/reports/create'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSecondaryAction(
                icon: Symbols.event_note,
                label: 'Plan einsehen',
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required String value,
    required IconData icon,
    Color? iconColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, color: iconColor ?? AppColors.primaryContainer, size: 24),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.navyDeep,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryAction(
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.outlineVariant),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: AppColors.primaryContainer, size: 20),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: AppColors.navyDeep,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextAssignment() {
    final shiftState = ref.watch(shiftProvider);
    final isActive = shiftState.status != ShiftStatus.offDuty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isActive ? 'AKTUELLER EINSATZ' : 'NÄCHSTER EINSATZ',
              style: TextStyle(
                color: AppColors.navyDeep,
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
            if (isActive)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'LIVE',
                  style: TextStyle(
                    color: AppColors.success,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => context.push('/shift'),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.navyDeep.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuCH_4imTzotsEZt8A_cpLPUU-SbFPTF-BwNr1Zdpb1VZQpKlFsCUvKME7Jh8GGhUimhVPFJOhKyMQ8pHLv4ugJsyfrehGRvz0njJyN21oB6AVTSynUMe_zi55fuonfkDawmu5q-2rpzDkBOImADqK0fVRB4B0o4WHKm0GnWp07lMiQegaOinQmTjh_TgEAudjLOMuaT60UkdSmXMOBR9PLjg3LcTSORym8DDPvlfboL0SUmsZtIf8lM0boLDjofjF2sm9Xotao1Puw',
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                AppColors.navyDeep.withOpacity(0.9),
                                AppColors.navyDeep.withOpacity(0.2),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 24,
                          left: 24,
                          right: 24,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Symbols.location_on, color: Colors.white, size: 14),
                                    SizedBox(width: 6),
                                    Text(
                                      'ZÜRICH • BAHNHOFSTRASSE 45',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'VERKEHRSDIENST ZÜRICH',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  height: 1.0,
                                  letterSpacing: -1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 20,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isActive ? Symbols.arrow_forward : Symbols.arrow_right_alt,
                              color: AppColors.navyDeep,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildAssignmentStat('START', '14:00 Uhr'),
                            const SizedBox(width: 16),
                            Container(width: 1, height: 32, color: AppColors.outlineVariant),
                            const SizedBox(width: 16),
                            _buildAssignmentStat('DAUER', '4.0 Std'),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () => context.push('/shift'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isActive ? AppColors.success : AppColors.navyDeep,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 4,
                            shadowColor: (isActive ? AppColors.success : AppColors.navyDeep).withOpacity(0.4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(isActive ? Symbols.cached : Symbols.login, size: 18),
                              const SizedBox(width: 8),
                              Text(
                                isActive ? 'ZUM COCKPIT' : 'STARTEN',
                                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAssignmentStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.navyLight.withOpacity(0.6),
            fontSize: 9,
            fontWeight: FontWeight.w900,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.navyDeep,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  Widget _buildNotifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'MITTEILUNGEN',
              style: TextStyle(
                color: AppColors.navyDeep,
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'ALLE ANSEHEN',
                style: TextStyle(
                  color: AppColors.navyLight.withOpacity(0.8),
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildNotificationCard(
          title: 'EINSATZPLAN AKTUALISIERT',
          message: 'Plan für KW 42 freigeschaltet. Schichtbestätigung erforderlich.',
          time: '12 MIN.',
          isNew: true,
        ),
        const SizedBox(height: 12),
        _buildNotificationCard(
          title: 'BERICHT VERIFIZIERT',
          message: 'Ihr Bericht vom 12.09. wurde vom Kunden signiert und archiviert.',
          time: '2 STD.',
          isNew: false,
        ),
      ],
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String message,
    required String time,
    required bool isNew,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isNew ? Colors.white : AppColors.backgroundAlt.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isNew ? AppColors.navyDeep.withOpacity(0.1) : AppColors.outlineVariant.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (isNew)
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                    ),
                  Text(
                    title,
                    style: TextStyle(
                      color: isNew ? AppColors.navyDeep : AppColors.navyLight,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              Text(
                time,
                style: TextStyle(
                  color: AppColors.navyLight.withOpacity(0.5),
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            message,
            style: TextStyle(
              color: AppColors.onSurfaceVariant.withOpacity(0.8),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TAGESABLAUF',
          style: TextStyle(
            color: AppColors.navyDeep,
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
          ),
          child: Column(
            children: [
              _buildTimelineItem(
                time: '08:00 — 12:00',
                title: 'OBJEKTSCHUTZ CARGO WEST',
                location: 'Areal Nord • Tor 4',
                isCompleted: true,
              ),
              const SizedBox(height: 24),
              _buildTimelineItem(
                time: '14:00 — 18:00',
                title: 'VERKEHRSDIENST ZÜRICH',
                location: 'Bahnhofstrasse 45',
                isCompleted: false,
                isCurrent: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required String time,
    required String title,
    required String location,
    bool isCompleted = false,
    bool isCurrent = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? AppColors.success
                      : (isCurrent ? AppColors.navyDeep : AppColors.outlineVariant),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: isCurrent
                      ? [BoxShadow(color: AppColors.navyDeep.withOpacity(0.3), blurRadius: 4)]
                      : null,
                ),
              ),
              Expanded(
                child: Container(
                  width: 2,
                  color: AppColors.outlineVariant.withOpacity(0.3),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: isCompleted ? AppColors.success : AppColors.navyLight,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyle(
                    color: isCompleted ? AppColors.navyDeep.withOpacity(0.6) : AppColors.navyDeep,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    color: AppColors.navyLight.withOpacity(0.6),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
