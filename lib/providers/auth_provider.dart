import '../main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  User? build() {
    final sub = supabase.auth.onAuthStateChange.listen((data) {
      state = data.session?.user;
    });
    ref.onDispose(() => sub.cancel());
    return supabase.auth.currentUser;
  }

  Future<void> signInWithMagicLink(String email) async {
    await supabase.auth.signInWithOtp(
      email: email,
      emailRedirectTo: kIsWeb
          ? 'https://d-a-vi-d.github.io/fridge_master/'
          : 'com.fridgemaster.app://login-callback/',
    );
  }

  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (_) {
      await supabase.auth.signOut(scope: SignOutScope.local);
    }
  }
}
