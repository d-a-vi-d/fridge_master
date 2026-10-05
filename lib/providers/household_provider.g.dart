// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Households)
final householdsProvider = HouseholdsProvider._();

final class HouseholdsProvider
    extends $AsyncNotifierProvider<Households, List<Household>> {
  HouseholdsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'householdsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$householdsHash();

  @$internal
  @override
  Households create() => Households();
}

String _$householdsHash() => r'87eb2ecd3b9b6d0de91a75d3acae185f5eae093c';

abstract class _$Households extends $AsyncNotifier<List<Household>> {
  FutureOr<List<Household>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Household>>, List<Household>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Household>>, List<Household>>,
              AsyncValue<List<Household>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(SelectedHouseholdId)
final selectedHouseholdIdProvider = SelectedHouseholdIdProvider._();

final class SelectedHouseholdIdProvider
    extends $NotifierProvider<SelectedHouseholdId, String?> {
  SelectedHouseholdIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedHouseholdIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedHouseholdIdHash();

  @$internal
  @override
  SelectedHouseholdId create() => SelectedHouseholdId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedHouseholdIdHash() =>
    r'0ebad2aa73ac91473c64cb4358c3c67a79ab5946';

abstract class _$SelectedHouseholdId extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
