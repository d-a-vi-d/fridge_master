import 'package:flutter/material.dart';
// import 'package:app_links/app_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_master/widgets/custom_page.dart';
import '../providers/auth_provider.dart';
import '../providers/household_provider.dart';
import '../screens/home_screen.dart';
import '../screens/household_screen.dart';
import '../screens/sign_in_screen.dart';
import '../utils/error_snackbar.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  static const _loading = Scaffold(body: Center(child: CircularProgressIndicator()));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    if (user == null) return const SignInScreen();

    final householdsAsync = ref.watch(householdsProvider);

    if (householdsAsync.hasError) {
      // return Scaffold(body: Center(child: Text('Fehler ${householdsAsync.error}')));

      // return Scaffold(body: Center(child: Text(getErrorMessage(householdsAsync.error))));
      return CustomPage(
        child: Column(
          children: [
            Text(getErrorMessage(householdsAsync.error)),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(householdsProvider);
              },
              child: Text("Erneut versuchen"),
            ),
            TextButton(
              onPressed: () => ref.read(authProvider.notifier).signOut(),
              child: Text("Ausloggen"),
            ),
          ],
        ),
      );
    }

    if (!householdsAsync.hasValue) {
      return _loading;
    }
    //TODO bis hierher gekommen
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
