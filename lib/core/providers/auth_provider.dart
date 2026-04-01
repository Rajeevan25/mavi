import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: deprecated_member_use_from_same_package
import 'package:flutter_riverpod/legacy.dart';

enum UserRole {
  guest,
  admin,
  employee,
}

/// A simple StateProvider holding the current mock role for the UI.
final authProvider = StateProvider<UserRole>((ref) => UserRole.guest);
