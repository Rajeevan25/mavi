// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ReportRepository)
final reportRepositoryProvider = ReportRepositoryProvider._();

final class ReportRepositoryProvider
    extends $NotifierProvider<ReportRepository, List<Report>> {
  ReportRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportRepositoryHash();

  @$internal
  @override
  ReportRepository create() => ReportRepository();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Report> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Report>>(value),
    );
  }
}

String _$reportRepositoryHash() => r'c346eb8d4c936f2b09a5916afe6ef275bc7ae2bc';

abstract class _$ReportRepository extends $Notifier<List<Report>> {
  List<Report> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Report>, List<Report>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Report>, List<Report>>,
              List<Report>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(NotificationRepository)
final notificationRepositoryProvider = NotificationRepositoryProvider._();

final class NotificationRepositoryProvider
    extends $NotifierProvider<NotificationRepository, List<NotificationItem>> {
  NotificationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'notificationRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationRepositoryHash();

  @$internal
  @override
  NotificationRepository create() => NotificationRepository();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<NotificationItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<NotificationItem>>(value),
    );
  }
}

String _$notificationRepositoryHash() =>
    r'139529d8709186150468eeac846b948b66796b9e';

abstract class _$NotificationRepository
    extends $Notifier<List<NotificationItem>> {
  List<NotificationItem> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<List<NotificationItem>, List<NotificationItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<NotificationItem>, List<NotificationItem>>,
              List<NotificationItem>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
