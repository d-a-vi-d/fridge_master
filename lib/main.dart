import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/app_shell.dart';
import 'utils/themes.dart';

final supabase = Supabase.instance.client;
final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  final supabaseUrl = dotenv.get('SUPABASE_URL');
  final anonKey = dotenv.get('SUPABASE_ANON_KEY');
  await Supabase.initialize(url: supabaseUrl, publishableKey: anonKey);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Fridge Master',
      theme: Themes.light,
      home: const AppShell(),
    );
  }
}
