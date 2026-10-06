import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_master/providers/auth_provider.dart';
import 'package:fridge_master/providers/household_provider.dart';
import 'package:fridge_master/screens/home_screen.dart';
import 'package:fridge_master/screens/household_screen.dart';
import 'package:fridge_master/screens/sign_in_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../main.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});
  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  final _appLinks = AppLinks();
  StreamSubscription? _linkSub;
  Uri? _lastHandledUri;

  Future<void> _handleInitialLink() async {
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri == null) return;
      _lastHandledUri = initialUri;
      await supabase.auth.getSessionFromUrl(initialUri);
    } on AuthApiException catch (e) {
      if (e.statusCode != '404') rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _handleInitialLink().then((_) {
        if (!mounted) return;
        _linkSub = _appLinks.uriLinkStream.listen((uri) async {
          if (uri == _lastHandledUri) return;
          _lastHandledUri = uri;
          try {
            await supabase.auth.getSessionFromUrl(uri);
          } on AuthApiException catch (e) {
            if (e.statusCode != '404') rethrow;
          }
        });
      });
    }
  }

  static const _loading = Scaffold(body: Center(child: CircularProgressIndicator()));

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);
    if (user == null) return const SignInScreen();

    final householdsAsync = ref.watch(householdsProvider);

    if (householdsAsync.hasError) {
      return Scaffold(body: Center(child: Text('Fehler: ${householdsAsync.error}')));
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

  @override
  void dispose() {
    _linkSub?.cancel();
    super.dispose();
  }
}
