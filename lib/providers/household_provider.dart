import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../main.dart';
import '../models/household.dart';
import '../services/household_service.dart';

part 'household_provider.g.dart';

@riverpod
HouseholdService householdService(Ref ref) => HouseholdService();

@riverpod
Stream<List<Household>> households(Ref ref) {
  return supabase
      .from('households')
      .stream(primaryKey: ['id'])
      .map((rows) => rows.map((e) => Household.fromJson(e)).toList());
}

@riverpod
class SelectedHouseholdId extends _$SelectedHouseholdId {
  @override
  String? build() => null;

  void select(String householdId) => state = householdId;
}
