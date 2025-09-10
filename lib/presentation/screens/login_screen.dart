// import 'package:flutter/material.dart';
// import 'package:flutter_login/flutter_login.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:quote_keeper/utils/config/providers.dart';
// import 'package:quote_keeper/utils/extensions/string_extensions.dart';
// import 'package:universal_platform/universal_platform.dart';

// class LoginScreen extends ConsumerWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authAsyncNotifier = ref.read(Providers.authAsyncProvider.notifier);

//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           colors: [
//             '0E8DF5'.getHexColor(),
//             '17CB89'.getHexColor(),
//           ],
//         ),
//       ),
//       child: FlutterLogin(
//         title: 'Quote Keeper',
//         theme: LoginTheme(
//           primaryColor: Colors.deepOrange,
//           accentColor: Colors.white,
//         ),
//         onSignup: (signupData) => authAsyncNotifier.signup(
//           email: signupData.name!,
//           password: signupData.password!,
//         ),
//         onRecoverPassword: (email) =>
//             authAsyncNotifier.recoverPassword(email: email),
//         onLogin: (loginData) => authAsyncNotifier.loginEmailPassword(
//           email: loginData.name,
//           password: loginData.password,
//         ),
//         loginProviders: <LoginProvider>[
//           // LoginProvider(
//           //   button: Buttons.googleDark,
//           //   label: 'Sign In with Google',
//           //   callback: () => authAsyncNotifier.googleSignIn(),
//           // ),
//           if (UniversalPlatform.isIOS || UniversalPlatform.isMacOS) ...[
//             LoginProvider(
//               button: Buttons.appleDark,
//               label: 'Sign In with Apple',
//               callback: () => authAsyncNotifier.appleSignIn(),
//             ),
//           ]
//         ],
//       ),
//     );
//   }
// }
