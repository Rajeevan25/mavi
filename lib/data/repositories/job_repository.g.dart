// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(JobRepository)
final jobRepositoryProvider = JobRepositoryProvider._();

final class JobRepositoryProvider
    extends $NotifierProvider<JobRepository, List<Job>> {
  JobRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jobRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jobRepositoryHash();

  @$internal
  @override
  JobRepository create() => JobRepository();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Job> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Job>>(value),
    );
  }
}

String _$jobRepositoryHash() => r'2c4a96a74d85a8b69955f9835bb6e4cb8eb1b50b';

abstract class _$JobRepository extends $Notifier<List<Job>> {
  List<Job> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Job>, List<Job>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Job>, List<Job>>,
              List<Job>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(jobById)
final jobByIdProvider = JobByIdFamily._();

final class JobByIdProvider extends $FunctionalProvider<Job?, Job?, Job?>
    with $Provider<Job?> {
  JobByIdProvider._({
    required JobByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'jobByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$jobByIdHash();

  @override
  String toString() {
    return r'jobByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Job?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Job? create(Ref ref) {
    final argument = this.argument as String;
    return jobById(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Job? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Job?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is JobByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$jobByIdHash() => r'94086c4ac3c9b7cba7f7e4fb00141321f8da5a71';

final class JobByIdFamily extends $Family
    with $FunctionalFamilyOverride<Job?, String> {
  JobByIdFamily._()
    : super(
        retry: null,
        name: r'jobByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  JobByIdProvider call(String id) =>
      JobByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'jobByIdProvider';
}

@ProviderFor(jobsByDate)
final jobsByDateProvider = JobsByDateFamily._();

final class JobsByDateProvider
    extends $FunctionalProvider<List<Job>, List<Job>, List<Job>>
    with $Provider<List<Job>> {
  JobsByDateProvider._({
    required JobsByDateFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'jobsByDateProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$jobsByDateHash();

  @override
  String toString() {
    return r'jobsByDateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<Job>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Job> create(Ref ref) {
    final argument = this.argument as DateTime;
    return jobsByDate(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Job> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Job>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is JobsByDateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$jobsByDateHash() => r'7b949478d42ac2ec9f683c1410aa82e859936300';

final class JobsByDateFamily extends $Family
    with $FunctionalFamilyOverride<List<Job>, DateTime> {
  JobsByDateFamily._()
    : super(
        retry: null,
        name: r'jobsByDateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  JobsByDateProvider call(DateTime date) =>
      JobsByDateProvider._(argument: date, from: this);

  @override
  String toString() => r'jobsByDateProvider';
}
