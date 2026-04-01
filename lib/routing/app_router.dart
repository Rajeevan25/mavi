import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../core/providers/auth_provider.dart';
import '../core/theme/app_colors.dart';

import '../features/auth/login_screen.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/dashboard/employee_dashboard_screen.dart';
import '../features/jobs/jobs_screen.dart';
import '../features/jobs/job_details_screen.dart';
import '../features/jobs/create_job_screen.dart';
import '../features/employees/employees_screen.dart';
import '../features/employees/employee_details_screen.dart';
import '../features/employees/employee_wallet_screen.dart';
import '../features/employees/create_employee_screen.dart';
import '../features/planning/planning_screen.dart';
import '../features/reports/reports_screen.dart';
import '../features/reports/report_details_screen.dart';
import '../features/notifications/notifications_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/shift/shift_screen.dart';
import '../features/shift/payroll_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class _RouterNotifier extends ChangeNotifier {
  _RouterNotifier(this._ref) {
    _ref.listen<UserRole>(authProvider, (_, __) => notifyListeners());
  }

  final Ref _ref;

  String? redirect(BuildContext context, GoRouterState state) {
    final role = _ref.read(authProvider);
    final isGuest = role == UserRole.guest;
    final isOnLogin = state.matchedLocation == '/login';

    if (isGuest && !isOnLogin) return '/login';
    if (!isGuest && isOnLogin) return '/dashboard';
    return null;
  }
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final notifier = _RouterNotifier(ref);
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    refreshListenable: notifier,
    redirect: notifier.redirect,
    routes: [
    GoRoute(
      path: '/login',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/profile',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ProfileScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainLayout(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) {
                return Consumer(builder: (context, ref, child) {
                  final role = ref.watch(authProvider);
                  return role == UserRole.employee ? const EmployeeDashboardScreen() : const DashboardScreen();
                });
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/shift',
              builder: (context, state) => const ShiftScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/planning',
              builder: (context, state) {
                return Consumer(builder: (context, ref, child) {
                  final role = ref.watch(authProvider);
                  // For employees, this is their combined schedule/planning view
                  return const PlanningScreen();
                });
              },
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/jobs',
              builder: (context, state) {
                return Consumer(builder: (context, ref, child) {
                  final role = ref.watch(authProvider);
                  // Employees don't see this branch in bottom nav, but it's used by Admin for Aufträge
                  return const JobsScreen();
                });
              },
              routes: [
                GoRoute(
                  path: 'create',
                  builder: (context, state) => const CreateJobScreen(),
                ),
                GoRoute(
                  path: ':id',
                  builder: (context, state) => JobDetailsScreen(jobId: state.pathParameters['id']!),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/employees',
              builder: (context, state) => const EmployeesScreen(),
              routes: [
                GoRoute(
                  path: 'create',
                  builder: (context, state) => const CreateEmployeeScreen(),
                ),
                GoRoute(
                  path: ':id',
                  builder: (context, state) => EmployeeDetailsScreen(employeeId: state.pathParameters['id']!),
                  routes: [
                    GoRoute(
                      path: 'wallet',
                      builder: (context, state) => EmployeeWalletScreen(employeeId: state.pathParameters['id']!),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/reports',
              builder: (context, state) => const ReportsScreen(),
              routes: [
                GoRoute(
                  path: 'create',
                  builder: (context, state) => CreateReportScreen(jobId: state.uri.queryParameters['jobId']),
                ),
                GoRoute(
                  path: ':id',
                  builder: (context, state) => ReportDetailsScreen(reportId: state.pathParameters['id']!),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/notifications',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: '/payroll',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const PayrollScreen(),
    ),
  ],
  );
});

class MainLayout extends ConsumerWidget {
  const MainLayout({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(authProvider);
    final isEmployeeMode = role == UserRole.employee;

    int activeIndex = navigationShell.currentIndex;
    if (isEmployeeMode) {
      // In Employee mode, branch indices 0, 1, 2 map directly to nav indices 0, 1, 2
      if (activeIndex > 2) activeIndex = 0;
    } else {
      // In Admin mode:
      // Nav 0 -> Branch 0 (Dashboard)
      // Nav 1 -> Branch 3 (Aufträge)
      // Nav 2 -> Branch 4 (Personal)
      // Nav 3 -> Branch 2 (Planung)
      // Nav 4 -> Branch 5 (Berichte)
      
      if (activeIndex == 0) activeIndex = 0;
      else if (activeIndex == 3) activeIndex = 1;
      else if (activeIndex == 4) activeIndex = 2;
      else if (activeIndex == 2) activeIndex = 3;
      else if (activeIndex == 5) activeIndex = 4;
      else activeIndex = 0; // Fallback
    }

    void onDestinationSelected(int index) {
      int branchIndex = index;
      if (!isEmployeeMode) {
        // Admin mapping from nav to branch
        if (index == 0) branchIndex = 0;
        else if (index == 1) branchIndex = 3;
        else if (index == 2) branchIndex = 4;
        else if (index == 3) branchIndex = 2;
        else if (index == 4) branchIndex = 5;
      }
      
      navigationShell.goBranch(
        branchIndex,
        initialLocation: branchIndex == navigationShell.currentIndex,
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: activeIndex,
        onDestinationSelected: onDestinationSelected,
        backgroundColor: Colors.white,
        indicatorColor: AppColors.primaryContainer.withOpacity(0.1),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        height: 64,
        destinations: isEmployeeMode
            ? const [
                NavigationDestination(
                  icon: Icon(Symbols.grid_view),
                  selectedIcon: Icon(Symbols.grid_view, fill: 1),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Symbols.schedule),
                  selectedIcon: Icon(Symbols.schedule, fill: 1),
                  label: 'Schicht',
                ),
                NavigationDestination(
                  icon: Icon(Symbols.calendar_today),
                  selectedIcon: Icon(Symbols.calendar_today, fill: 1),
                  label: 'Plan',
                ),
              ]
            : const [
                NavigationDestination(
                  icon: Icon(Symbols.dashboard),
                  selectedIcon: Icon(Symbols.dashboard, fill: 1),
                  label: 'Dashboard',
                ),
                NavigationDestination(
                  icon: Icon(Symbols.work),
                  selectedIcon: Icon(Symbols.work, fill: 1),
                  label: 'Aufträge',
                ),
                NavigationDestination(
                  icon: Icon(Symbols.group),
                  selectedIcon: Icon(Symbols.group, fill: 1),
                  label: 'Personal',
                ),
                NavigationDestination(
                  icon: Icon(Symbols.calendar_month),
                  selectedIcon: Icon(Symbols.calendar_month, fill: 1),
                  label: 'Planung',
                ),
                NavigationDestination(
                  icon: Icon(Symbols.assessment),
                  selectedIcon: Icon(Symbols.assessment, fill: 1),
                  label: 'Berichte',
                ),
              ],
      ),
    );
  }
}
