import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/employee.dart';
import '../mock/mock_data.dart';

part 'employee_repository.g.dart';

@riverpod
class EmployeeRepository extends _$EmployeeRepository {
  @override
  List<Employee> build() {
    return MockData.employees;
  }

  void addEmployee(Employee employee) {
    state = [...state, employee];
  }

  void updateEmployeeStatus(String id, EmployeeStatus status) {
    state = [
      for (final employee in state)
        if (employee.id == id) employee.copyWith(status: status) else employee,
    ];
  }
}

@riverpod
Employee? employeeById(Ref ref, String id) {
  final employees = ref.watch(employeeRepositoryProvider);
  try {
    return employees.firstWhere((e) => e.id == id);
  } catch (_) {
    return null;
  }
}
