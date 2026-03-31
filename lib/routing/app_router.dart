import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import '../features/dashboard/dashboard_screen.dart';
import '../features/jobs/jobs_screen.dart';
import '../features/jobs/job_details_screen.dart';
import '../features/jobs/create_job_screen.dart';
import '../features/employees/employees_screen.dart';
import '../features/employees/employee_details_screen.dart';
import '../features/employees/create_employee_screen.dart';
import '../features/planning/planning_screen.dart';
import '../features/reports/reports_screen.dart';
import '../features/reports/report_details_screen.dart';
import '../features/notifications/notifications_screen.dart';
import '../features/profile/profile_screen.dart';
import 'package:mavi_security/core/theme/app_colors.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/dashboard',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainLayout(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/jobs',
              builder: (context, state) => const JobsScreen(),
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
                ),
              ],
            ),
          ],
        ),
         StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/planning',
              builder: (context, state) => const PlanningScreen(),
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
      path: '/profile',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);

class MainLayout extends StatelessWidget {
  const MainLayout({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
            backgroundColor: Colors.white,
            indicatorColor: AppColors.primaryContainer.withOpacity(0.1),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            height: 64,
            destinations: const [
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
        ),
      ),
    );
  }
}
