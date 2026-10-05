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
      title: 'FridgeMaster',
      theme: Themes.light,
      home: const AppShell(),
    );
  }
}
// Supabase-Client in Flutter verbinden, Auth (minimal, nur damit RLS greift)
// Scan-Flow Einräumen: Kamera → Barcode → Open Food Facts lookup → in inventory_items speichern/erhöhen
// Scan-Flow Verbrauchen: Kamera → Barcode → in inventory_items verringern/löschen
// Produkt hinzufügen (unbekannter Code): manuelles Formular → landet in products
// Übersicht: Liste aus inventory_items + Join auf products
