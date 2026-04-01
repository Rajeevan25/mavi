import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:mavi_security/core/theme/app_colors.dart';
import 'package:mavi_security/core/utils/location_utils.dart';

// Mock Provider for Shift State
final shiftProvider = NotifierProvider<ShiftNotifier, ShiftState>(ShiftNotifier.new);

enum ShiftStatus { offDuty, onDuty, onBreak }

class ShiftState {
  final ShiftStatus status;
  final DateTime? startTime;
  final DateTime? breakStartTime;
  final Duration totalBreakTime;
  final double walletBalance;
  final double currentShiftEarnings;
  final bool outOfBoundsFlag;

  ShiftState({
    this.status = ShiftStatus.offDuty,
    this.startTime,
    this.breakStartTime,
    this.totalBreakTime = Duration.zero,
    this.walletBalance = 450.00, 
    this.currentShiftEarnings = 0.0,
    this.outOfBoundsFlag = false,
  });

  ShiftState copyWith({
    ShiftStatus? status,
    DateTime? startTime,
    DateTime? breakStartTime,
    Duration? totalBreakTime,
    double? walletBalance,
    double? currentShiftEarnings,
    bool? outOfBoundsFlag,
  }) {
    return ShiftState(
      status: status ?? this.status,
      startTime: startTime ?? this.startTime,
      breakStartTime: breakStartTime ?? this.breakStartTime,
      totalBreakTime: totalBreakTime ?? this.totalBreakTime,
      walletBalance: walletBalance ?? this.walletBalance,
      currentShiftEarnings: currentShiftEarnings ?? this.currentShiftEarnings,
      outOfBoundsFlag: outOfBoundsFlag ?? this.outOfBoundsFlag,
    );
  }
}

class ShiftNotifier extends Notifier<ShiftState> {
  Timer? _ticker;

  @override
  ShiftState build() {
    ref.onDispose(() => _ticker?.cancel());
    return ShiftState();
  }
  
  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.status == ShiftStatus.onDuty && state.startTime != null) {
        final now = DateTime.now();
        final totalDuration = now.difference(state.startTime!) - state.totalBreakTime;
        final hours = totalDuration.inSeconds / 3600.0;
        state = state.copyWith(currentShiftEarnings: hours * hourlyRate);
      }
    });
  }

  void _stopTicker() => _ticker?.cancel();
  
  // Mock Target Location (Using a dummy location like Berlin center)
  final double jobLat = 52.5200;
  final double jobLng = 13.4050;
  final double hourlyRate = 25.0;

  Future<void> checkIn(BuildContext context) async {
    // Geofencing Check
    try {
      bool isWithin = await LocationUtils.isWithinGeofence(jobLat, jobLng);
      if (!isWithin) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Warning: You are outside the client geofence! Shift flagged.'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
      
      state = state.copyWith(
        status: ShiftStatus.onDuty,
        startTime: DateTime.now(),
        outOfBoundsFlag: !isWithin,
        totalBreakTime: Duration.zero,
        currentShiftEarnings: 0.0,
      );
      _startTicker();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('GPS Error: ${e.toString()}'), backgroundColor: AppColors.error,),
        );
      }
      // Allow check in but flag it
       state = state.copyWith(
        status: ShiftStatus.onDuty,
        startTime: DateTime.now(),
        outOfBoundsFlag: true,
        totalBreakTime: Duration.zero,
      );
    }
  }

  void takeBreak() {
    state = state.copyWith(
      status: ShiftStatus.onBreak,
      breakStartTime: DateTime.now(),
    );
  }

  void endBreak() {
    if (state.breakStartTime != null) {
      final breakDuration = DateTime.now().difference(state.breakStartTime!);
      state = state.copyWith(
        status: ShiftStatus.onDuty,
        breakStartTime: null,
        totalBreakTime: state.totalBreakTime + breakDuration,
      );
    }
  }

  Future<void> checkOut(BuildContext context) async {
    if (state.startTime == null) return;
    
    // Geofencing Check
    try {
      bool isWithin = await LocationUtils.isWithinGeofence(jobLat, jobLng);
      if (!isWithin && !state.outOfBoundsFlag) {
         state = state.copyWith(outOfBoundsFlag: true);
      }
    } catch (_) { }

    final endTime = DateTime.now();
    Duration totalTime = endTime.difference(state.startTime!);
    
    // Unpaid breaks deduction
    if (state.status == ShiftStatus.onBreak && state.breakStartTime != null) {
        final currentBreak = endTime.difference(state.breakStartTime!);
        state = state.copyWith(totalBreakTime: state.totalBreakTime + currentBreak);
    }

    Duration paidTime = totalTime - state.totalBreakTime;
    if (paidTime.isNegative) paidTime = Duration.zero;

    // Calculate Wallet Earnings. For testing mock UI, we will just pretend they worked more hours if paidTime is too low,
    // or just calculate natively. 
    double hoursWorked = paidTime.inSeconds / 3600.0;
    
    // Mocking an 8-hour shift purely for demonstration if they check out immediately.
    if (hoursWorked < 0.1) {
       hoursWorked = 8.0; 
    }

    double earned = hoursWorked * hourlyRate;

    state = state.copyWith(
      status: ShiftStatus.offDuty,
      startTime: null,
      breakStartTime: null,
      walletBalance: state.walletBalance + earned,
      currentShiftEarnings: 0.0,
    );
    _stopTicker();

    if (context.mounted) {
       // Navigate directly to the Detailed Report creation page
       context.push('/reports/create');
    }
  }
}


class ShiftScreen extends ConsumerStatefulWidget {
  const ShiftScreen({super.key});

  @override
  ConsumerState<ShiftScreen> createState() => _ShiftScreenState();
}

class _ShiftScreenState extends ConsumerState<ShiftScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shiftState = ref.watch(shiftProvider);
    final shiftNotifier = ref.read(shiftProvider.notifier);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'EINSATZ COCKPIT',
          style: TextStyle(
            color: AppColors.navyDeep,
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () => context.push('/profile'),
              child: const CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBBKq3dXmpR10eWP7wuQUbzN_tjAg3060UvIGXNCm6ywWZtG_Ex7UONsRicBCkApqPbvoygv_f6-OFTbvIeq_gRU4L5XtuAT9ITT9AB24YDi2_pMFI2BZGKjsgNV3b9upabNKU1MiHBDujNU6naeU8kxQIJkqfgOR1MGlB1I0icEAm7uVzsqCoCSuvhxkov9zw5fSaCHlfgUiOBRBrWroUg3fsXUWaBZ63IgV3OvZq-VHMAy5tTZx-c3mizQNbbA-oODoOvmAuwx3E'),
              ),
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Symbols.arrow_back, color: AppColors.navyDeep),
          onPressed: () => context.canPop() ? context.pop() : context.go('/dashboard'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStatusCard(shiftState),
              const SizedBox(height: 24),
              _buildJobDetails(),
              const SizedBox(height: 24),
              _buildActionWidgets(context, shiftState, shiftNotifier),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildJobDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.navyDeep.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Symbols.assignment, color: AppColors.navyDeep, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                'AUFTRAGSDETAILS',
                style: TextStyle(
                  color: AppColors.navyDeep,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDetailItem(Symbols.location_on, 'Standort', 'Bahnhofstrasse 45, 8001 Zürich'),
          const Divider(height: 32),
          _buildDetailItem(Symbols.person, 'Ansprechpartner', 'Hr. Steiner (+41 79 123 45 67)'),
          const Divider(height: 32),
          _buildDetailItem(
            Symbols.info,
            'Anweisungen',
            'Zutrittskontrolle Haupteingang. Patrouillen alle 60 Min. Funk auf Kanal 4.',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.navyLight, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  color: AppColors.navyLight.withOpacity(0.6),
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.navyDeep,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard(ShiftState state) {
    Color statusColor;
    String statusLabel;
    IconData statusIcon;

    switch (state.status) {
      case ShiftStatus.offDuty:
        statusColor = AppColors.slate;
        statusLabel = 'BEREIT ZUM CHECK-IN';
        statusIcon = Symbols.fingerprint;
        break;
      case ShiftStatus.onDuty:
        statusColor = AppColors.success;
        statusLabel = 'IM DIENST';
        statusIcon = Symbols.verified_user;
        break;
      case ShiftStatus.onBreak:
        statusColor = AppColors.warning;
        statusLabel = 'PAUSE AKTIV';
        statusIcon = Symbols.coffee;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.navyDeep,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.navyDeep.withOpacity(0.2),
            offset: const Offset(0, 10),
            blurRadius: 20,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(Symbols.location_searching, color: Colors.white, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      state.outOfBoundsFlag ? 'GPS FEHLER' : 'GPS VERIFIZIERT',
                      style: TextStyle(
                        color: state.outOfBoundsFlag ? Colors.red[300] : Colors.green[300],
                        fontSize: 9,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              if (state.status != ShiftStatus.offDuty)
                Text(
                  '€ ${state.currentShiftEarnings.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 32),
          Icon(statusIcon, size: 64, color: statusColor),
          const SizedBox(height: 16),
          Text(
            statusLabel,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 1.0,
            ),
          ),
          if (state.status != ShiftStatus.offDuty)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05 + (0.05 * _pulseController.value)),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1 + (0.2 * _pulseController.value)),
                      ),
                    ),
                    child: Text(
                      'GESTARTET UM ${state.startTime!.hour.toString().padLeft(2, '0')}:${state.startTime!.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6 + (0.4 * _pulseController.value)),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionWidgets(BuildContext context, ShiftState state, ShiftNotifier notifier) {
    if (state.status == ShiftStatus.offDuty) {
      return _buildActionRow([
        _buildTacticalButton(
          label: 'CHECK-IN',
          subLabel: 'Starten Sie Ihre Schicht',
          color: AppColors.success,
          icon: Symbols.login,
          onTap: () => notifier.checkIn(context),
          isPrimary: true,
        ),
      ]);
    } else if (state.status == ShiftStatus.onDuty) {
      return Column(
        children: [
          _buildActionRow([
            _buildTacticalButton(
              label: 'PAUSE STARTEN',
              subLabel: '30 Min. unbezahlt',
              color: AppColors.warning,
              icon: Symbols.coffee,
              onTap: () => notifier.takeBreak(),
            ),
            const SizedBox(width: 16),
            _buildTacticalButton(
              label: 'CHECK-OUT',
              subLabel: 'Schicht beenden',
              color: AppColors.error,
              icon: Symbols.logout,
              onTap: () => notifier.checkOut(context),
            ),
          ]),
          const SizedBox(height: 16),
          _buildTacticalButton(
            label: 'PROTOKOLL SCHREIBEN',
            subLabel: 'Vorfall melden',
            color: AppColors.navyDeep,
            icon: Symbols.edit_document,
            onTap: () {},
            isFullWidth: true,
          ),
        ],
      );
    } else if (state.status == ShiftStatus.onBreak) {
      return _buildActionRow([
        _buildTacticalButton(
          label: 'PAUSE BEENDEN',
          subLabel: 'Zurück zum Dienst',
          color: AppColors.success,
          icon: Symbols.play_arrow,
          onTap: () => notifier.endBreak(),
          isPrimary: true,
        ),
      ]);
    }
    return const SizedBox.shrink();
  }

  Widget _buildActionRow(List<Widget> children) {
    return Row(
      children: children.map((w) => w is Expanded ? w : Expanded(child: w)).toList(),
    );
  }

  Widget _buildTacticalButton({
    required String label,
    required String subLabel,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
    bool isPrimary = false,
    bool isFullWidth = false,
  }) {
    final body = Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: isPrimary ? color : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isPrimary ? color : AppColors.outlineVariant.withOpacity(0.5)),
        boxShadow: [
          if (isPrimary)
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isPrimary ? Colors.white : color, size: 28),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(
              color: isPrimary ? Colors.white : AppColors.navyDeep,
              fontSize: 13,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subLabel,
            style: TextStyle(
              color: (isPrimary ? Colors.white : AppColors.navyLight).withOpacity(0.7),
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: isFullWidth ? SizedBox(width: double.infinity, child: body) : body,
      ),
    );
  }
}
