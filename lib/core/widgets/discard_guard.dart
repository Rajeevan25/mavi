import 'package:flutter/material.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

/// Wraps a form screen and shows a "Discard changes?" dialog when the
/// user tries to navigate back while the form has unsaved content.
///
/// Usage:
///   DiscardGuard(
///     hasChanges: () => _nameController.text.isNotEmpty,
///     child: Scaffold(...),
///   )
class DiscardGuard extends StatelessWidget {
  const DiscardGuard({
    required this.hasChanges,
    required this.child,
    super.key,
  });

  final bool Function() hasChanges;
  final Widget child;

  Future<bool> _confirmDiscard(BuildContext context) async {
    if (!hasChanges()) return true;
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Änderungen verwerfen?',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.navyDeep),
        ),
        content: const Text(
          'Wenn Sie jetzt zurückgehen, gehen alle nicht gespeicherten Änderungen verloren.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('WEITER BEARBEITEN'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('VERWERFEN',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final shouldPop = await _confirmDiscard(context);
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: child,
    );
  }
}
