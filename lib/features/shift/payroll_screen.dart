import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

// Mock Provider for Payroll Employees
class PayrollNotifier extends Notifier<List<Map<String, dynamic>>> {
  @override
  List<Map<String, dynamic>> build() {
    return [
      {'name': 'Alex Schmidt', 'role': 'Security Guard', 'hours': 160.0, 'rate': 25.0, 'balance': 4000.0, 'flagged': false},
      {'name': 'Sarah Meyer', 'role': 'Patrol Officer', 'hours': 110.5, 'rate': 25.0, 'balance': 2762.5, 'flagged': true},
      {'name': 'Markus Fischer', 'role': 'Event Security', 'hours': 45.0, 'rate': 30.0, 'balance': 1350.0, 'flagged': false},
    ];
  }
}

final payrollProvider = NotifierProvider<PayrollNotifier, List<Map<String, dynamic>>>(PayrollNotifier.new);

class PayrollScreen extends ConsumerWidget {
  const PayrollScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payrollData = ref.watch(payrollProvider);
    final totalPayout = payrollData.fold(0.0, (sum, item) => sum + (item['balance'] as double));

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('End of Month Payroll Auto-Report'),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSummaryCard(totalPayout),
               const SizedBox(height: 24),
               const Text('Employee Breakdown', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
               const SizedBox(height: 16),
               Expanded(
                 child: ListView.builder(
                   itemCount: payrollData.length,
                   itemBuilder: (context, index) {
                     final employee = payrollData[index];
                     return _buildEmployeeCard(employee);
                   },
                 ),
               ),
               const SizedBox(height: 16),
               ElevatedButton.icon(
                 onPressed: () {
                   // Mock clearing wallets
                   ref.read(payrollProvider.notifier).state = [];
                   ScaffoldMessenger.of(context).showSnackBar(
                     const SnackBar(content: Text('All wallets cleared and payout marked as Paid.', style: TextStyle(color: Colors.white)), backgroundColor: AppColors.success),
                   );
                 },
                 style: ElevatedButton.styleFrom(
                   backgroundColor: AppColors.primary,
                   foregroundColor: Colors.white,
                   padding: const EdgeInsets.symmetric(vertical: 20),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                 ),
                 icon: const Icon(Symbols.payments),
                 label: const Text('APPROVE PAYOUT & CLEAR WALLETS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
               )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(double total) {
     return Container(
       padding: const EdgeInsets.all(32),
       decoration: BoxDecoration(
         gradient: const LinearGradient(
           colors: [AppColors.primary, AppColors.primaryDark],
           begin: Alignment.topLeft,
           end: Alignment.bottomRight,
         ),
         borderRadius: BorderRadius.circular(24),
         boxShadow: [
           BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10))
         ]
       ),
       child: Column(
         children: [
           const Icon(Symbols.account_balance, color: Colors.white, size: 48),
           const SizedBox(height: 16),
           const Text('Total Month Payout', style: TextStyle(color: Colors.white70, fontSize: 16)),
           Text('€${total.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
         ],
       )
     );
  }

  Widget _buildEmployeeCard(Map<String, dynamic> emp) {
     bool hasFlag = emp['flagged'];
     return Container(
       margin: const EdgeInsets.only(bottom: 12),
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(16),
         border: hasFlag ? Border.all(color: AppColors.error, width: 2) : Border.all(color: Colors.grey[200]!),
       ),
       child: ListTile(
         contentPadding: const EdgeInsets.all(16),
         leading: CircleAvatar(
           backgroundColor: AppColors.primaryContainer.withOpacity(0.2),
           child: Text(emp['name'][0], style: const TextStyle(color: AppColors.primary)),
         ),
         title: Row(
           children: [
             Text(emp['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
             if (hasFlag) ...[
               const SizedBox(width: 8),
               Container(
                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                 decoration: BoxDecoration(color: AppColors.error.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                 child: const Text('GPS Flag', style: TextStyle(color: AppColors.error, fontSize: 10, fontWeight: FontWeight.bold)),
               )
             ]
           ],
         ),
         subtitle: Padding(
           padding: const EdgeInsets.only(top: 8.0),
           child: Text('${emp['hours']} hrs @ €${emp['rate']}/hr\n${emp['role']}'),
         ),
         trailing: Text('€${emp['balance'].toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.success)),
         isThreeLine: true,
       ),
     );
  }
}
