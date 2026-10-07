import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fridge_master/providers/auth_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/custom_page.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});
  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _emailController = TextEditingController();
  bool _linkSent = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: 'Anmelden',
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(_error!, style: const TextStyle(color: Colors.red)),
              ),
            if (_linkSent)
              const Text('Link geschickt — Mail-Postfach checken')
            else ...[
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-Mail'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await ref
                        .read(authProvider.notifier)
                        .signInWithMagicLink(_emailController.text.trim());
                    setState(() => _linkSent = true);
                  } on AuthException catch (e) {
                    if (e.statusCode == '429') {
                      setState(() => _error = 'Zu viele Versuche. Bitte warte ein paar Minuten.');
                    } else {
                      setState(() => _error = e.message);
                    }
                  } catch (e) {
                    setState(() => _error = 'Das hat nicht geklappt. Bitte nochmal versuchen.');
                  }
                },
                child: const Text('Magic Link senden'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
