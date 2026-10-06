import '../main.dart';
import '../models/household.dart';

class HouseholdService {
  Future<Household> create(String name) async {
    final res = await supabase.from('households').insert({'name': name}).select().single();
    final household = Household.fromJson(res);
    await supabase.from('household_members').insert({
      'household_id': household.id,
      'user_id': supabase.auth.currentUser!.id,
    });
    return household;
  }

  Future<Household> join(String code) async {
    final res = await supabase
        .from('households')
        .select()
        .eq('invite_code', code.toUpperCase())
        .maybeSingle();
    if (res == null) throw Exception('Einladungscode nicht gefunden');

    final household = Household.fromJson(res);
    await supabase.from('household_members').insert({
      'household_id': household.id,
      'user_id': supabase.auth.currentUser!.id,
    });
    return household;
  }
}
