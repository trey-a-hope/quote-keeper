import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quote_keeper/utils/config/providers.dart';
import 'package:quote_keeper/presentation/pages/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:quote_keeper/presentation/screens/dashboard_screen.dart';
import 'package:quote_keeper/presentation/screens/splash_screen.dart';

class AuthCheckerScreen extends ConsumerWidget {
  const AuthCheckerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      ref.watch(Providers.authAsyncNotifierProvider).when(
            data: (user) =>
                user == null ? const LoginView() : DashboardScreen(),
            error: (e, s) => Center(child: Text(e.toString())),
            loading: () => const SplashScreen(),
          );
}
