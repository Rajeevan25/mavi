// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EmployeeRepository)
final employeeRepositoryProvider = EmployeeRepositoryProvider._();

final class EmployeeRepositoryProvider
    extends $NotifierProvider<EmployeeRepository, List<Employee>> {
  EmployeeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'employeeRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$employeeRepositoryHash();

  @$internal
  @override
  EmployeeRepository create() => EmployeeRepository();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Employee> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Employee>>(value),
    );
  }
}

String _$employeeRepositoryHash() =>
    r'f96fbbb067634ebae9a47b1bbe43d3b9e0e370d3';

abstract class _$EmployeeRepository extends $Notifier<List<Employee>> {
  List<Employee> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Employee>, List<Employee>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Employee>, List<Employee>>,
              List<Employee>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(employeeById)
final employeeByIdProvider = EmployeeByIdFamily._();

final class EmployeeByIdProvider
    extends $FunctionalProvider<Employee?, Employee?, Employee?>
    with $Provider<Employee?> {
  EmployeeByIdProvider._({
    required EmployeeByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'employeeByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$employeeByIdHash();

  @override
  String toString() {
    return r'employeeByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Employee?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Employee? create(Ref ref) {
    final argument = this.argument as String;
    return employeeById(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Employee? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Employee?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EmployeeByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$employeeByIdHash() => r'df0c770631317850fb9f0eb5832e0801bf7c75f7';

final class EmployeeByIdFamily extends $Family
    with $FunctionalFamilyOverride<Employee?, String> {
  EmployeeByIdFamily._()
    : super(
        retry: null,
        name: r'employeeByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EmployeeByIdProvider call(String id) =>
      EmployeeByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'employeeByIdProvider';
}
