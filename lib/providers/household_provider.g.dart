// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(householdService)
final householdServiceProvider = HouseholdServiceProvider._();

final class HouseholdServiceProvider
    extends
        $FunctionalProvider<
          HouseholdService,
          HouseholdService,
          HouseholdService
        >
    with $Provider<HouseholdService> {
  HouseholdServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'householdServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$householdServiceHash();

  @$internal
  @override
  $ProviderElement<HouseholdService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HouseholdService create(Ref ref) {
    return householdService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HouseholdService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HouseholdService>(value),
    );
  }
}

String _$householdServiceHash() => r'780dc3efeb9f875b9929ddda9e77a5f644f22e71';

@ProviderFor(households)
final householdsProvider = HouseholdsProvider._();

final class HouseholdsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Household>>,
          List<Household>,
          Stream<List<Household>>
        >
    with $FutureModifier<List<Household>>, $StreamProvider<List<Household>> {
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
  $StreamProviderElement<List<Household>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Household>> create(Ref ref) {
    return households(ref);
  }
}

String _$householdsHash() => r'3eb405b07c156c441c865fb073dab0b10f97afc8';

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
