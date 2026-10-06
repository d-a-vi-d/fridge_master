import 'package:fridge_master/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/household.dart';

part 'household_provider.g.dart';

@riverpod
class Households extends _$Households {
  @override
  Future<List<Household>> build() => _getMyHouseholds();

  Future<void> refresh() async {
    state = await AsyncValue.guard(() => _getMyHouseholds());
  }

  Future<Household> create(String name) async {
    // final household = await _householdService.createHousehold(name);
    final res = await supabase.from('households').insert({'name': name}).select().single();
    final household = Household.fromJson(res);
    await supabase.from('household_members').insert({
      'household_id': household.id,
      'user_id': supabase.auth.currentUser!.id,
    });
    await refresh();
    ref.read(selectedHouseholdIdProvider.notifier).select(household.id);
    return household;
  }

  Future<Household> join(String code) async {
    // final household = await _householdService.joinByCode(code);
    final res = await supabase
        .from('households')
        .select()
        .eq('invite_code', code.toUpperCase())
        .maybeSingle();
    if (res == null) {
      throw Exception('Einladungscode nicht gefunden');
    }
    final household = Household.fromJson(res);
    await supabase.from('household_members').insert({
      'household_id': household.id,
      'user_id': supabase.auth.currentUser!.id,
    });

    await refresh();
    ref.read(selectedHouseholdIdProvider.notifier).select(household.id);
    return household;
  }

  Future<List<Household>> _getMyHouseholds() async {
    final res = await supabase
        .from('household_members')
        .select('households(*)')
        .eq('user_id', supabase.auth.currentUser!.id);

    return (res as List)
        .map((e) => Household.fromJson(e['households'] as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
class SelectedHouseholdId extends _$SelectedHouseholdId {
  @override
  String? build() => null; // wird gesetzt, sobald Haushalte geladen sind oder User wählt

  void select(String householdId) => state = householdId;
}
