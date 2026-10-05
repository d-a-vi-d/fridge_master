import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/household.dart';
import '../services/household_service.dart';

part 'household_provider.g.dart';

final _householdService = HouseholdService();

@riverpod
class Households extends _$Households {
  @override
  Future<List<Household>> build() => _householdService.getMyHouseholds();

  Future<void> refresh() async {
    state = await AsyncValue.guard(() => _householdService.getMyHouseholds());
  }

  Future<Household> create(String name) async {
    final household = await _householdService.createHousehold(name);
    await refresh();
    ref.read(selectedHouseholdIdProvider.notifier).select(household.id);
    return household;
  }

  Future<Household> join(String code) async {
    final household = await _householdService.joinByCode(code);
    await refresh();
    ref.read(selectedHouseholdIdProvider.notifier).select(household.id);
    return household;
  }
}

@riverpod
class SelectedHouseholdId extends _$SelectedHouseholdId {
  @override
  String? build() => null; // wird gesetzt, sobald Haushalte geladen sind oder User wählt

  void select(String householdId) => state = householdId;
}
