import 'package:flutter/material.dart';
// import 'package:app_links/app_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../providers/household_provider.dart';
import '../screens/home_screen.dart';
import '../screens/household_screen.dart';
import '../screens/sign_in_screen.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  static const _loading = Scaffold(body: Center(child: CircularProgressIndicator()));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    if (user == null) return const SignInScreen();

    final householdsAsync = ref.watch(householdsProvider);

    if (householdsAsync.hasError) {
      return Scaffold(body: Center(child: Text('Fehler ${householdsAsync.error}')));
    }
    //TODO bis hierher gekommen
    if (!householdsAsync.hasValue) {
      return _loading;
    }

    final households = householdsAsync.value!;
    if (households.isEmpty) return const HouseholdScreen();

    final selected = ref.watch(selectedHouseholdIdProvider);
    if (selected == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(selectedHouseholdIdProvider.notifier).select(households.first.id);
      });
      return _loading;
    }

    return const HomeScreen();
  }
}
