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
  // final _appLinks = AppLinks();
  // StreamSubscription? _linkSub;
  // Uri? _lastHandledUri;

  // Future<void> _handleInitialLink() async {
  //   try {
  //     final initialUri = await _appLinks.getInitialLink();
  //     if (initialUri == null) return;
  //     _lastHandledUri = initialUri;
  //     await supabase.auth.getSessionFromUrl(initialUri);
  //   } on AuthApiException catch (e) {
  //     if (supabase.auth.currentSession != null) rethrow;
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   if (!kIsWeb) {
  //     _handleInitialLink().then((_) {
  //       //hat keine Fehlerbehandlung
  //       if (!mounted) return;
  //       _linkSub = _appLinks.uriLinkStream.listen((uri) async {
  //         // Fehler werden geschluckt
  //         if (uri == _lastHandledUri) return;
  //         _lastHandledUri = uri;
  //         try {
  //           await supabase.auth.getSessionFromUrl(uri);
  //         } on AuthApiException catch (e) {
  //           if (e.statusCode != '404') rethrow;
  //         }
  //       });
  //     });
  //   }
  // }

  static const _loading = Scaffold(body: Center(child: CircularProgressIndicator()));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    if (user == null) return const SignInScreen();

    final householdsAsync = ref.watch(householdsProvider);

    if (householdsAsync.hasError) {
      return Scaffold(body: Center(child: Text('Fehler ${householdsAsync.error}')));
    }
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

  // @override
  // void dispose() {
  //    _linkSub?.cancel();
  //   super.dispose();
  // }
}
