import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import '../../data/repositories/report_repository.dart';
import '../../data/models/notification_item.dart';
import 'package:go_router/go_router.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mitteilungszentrale'),
        actions: [
          IconButton(
            onPressed: () => ref.read(notificationRepositoryProvider.notifier).markAllAsRead(),
            icon: const Icon(Symbols.done_all),
            tooltip: 'Alle als gelesen markieren',
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(child: Text('Keine Mitteilungen'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];
                return _buildNotificationCard(context, item, ref);
              },
            ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, NotificationItem item, WidgetRef ref) {
    final Color typeColor;
    final IconData typeIcon;

    switch (item.type) {
      case NotificationType.urgent:
        typeColor = AppColors.error;
        typeIcon = Symbols.warning;
        break;
      case NotificationType.warning:
        typeColor = Colors.orange;
        typeIcon = Symbols.error;
        break;
      case NotificationType.success:
        typeColor = Colors.green;
        typeIcon = Symbols.check_circle;
        break;
      default:
        typeColor = AppColors.primaryContainer;
        typeIcon = Symbols.info;
    }

    return Opacity(
      opacity: item.isRead ? 0.6 : 1.0,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: item.isRead ? null : Border.all(color: typeColor.withOpacity(0.1), width: 1),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: ListTile(
          onTap: () {
            ref.read(notificationRepositoryProvider.notifier).markAsRead(item.id);
            if (item.route != null) {
              context.push(item.route!);
            }
          },
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: typeColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(typeIcon, color: typeColor, fill: item.isRead ? 0 : 1),
          ),
          title: Text(
            item.title,
            style: TextStyle(
              fontWeight: item.isRead ? FontWeight.bold : FontWeight.w900,
              fontSize: 15,
              color: AppColors.navyDeep,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(item.message, style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6))),
              const SizedBox(height: 8),
              Text(
                'Vor ${_timeAgo(item.timestamp)}',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.3)),
              ),
            ],
          ),
          trailing: item.isRead
              ? null
              : Container(width: 8, height: 8, decoration: BoxDecoration(color: typeColor, shape: BoxShape.circle)),
        ),
      ),
    );
  }

  String _timeAgo(DateTime timestamp) {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 60) return '${diff.inMinutes} Min.';
    if (diff.inHours < 24) return '${diff.inHours} Std.';
    return '${diff.inDays} Tg.';
  }
}
