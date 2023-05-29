import 'dart:io';

import 'package:book_quotes/utils/extensions/hex_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<_LoginViewModel>(
      init: _LoginViewModel(),
      builder: (model) {
        // NewVersion().showAlertIfNecessary(context: context);

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                HexColor('0E8DF5'),
                HexColor('17CB89'),
              ],
            ),
          ),
          child: FlutterLogin(
            title: 'Book Quotes',
            logo: 'assets/images/logo.png',
            theme: LoginTheme(
              primaryColor: Colors.deepOrange,
              accentColor: Colors.white,
            ),
            onSignup: (signupData) => model.signup(
              email: signupData.name!,
              password: signupData.password!,
            ),
            onRecoverPassword: (email) => model.recoverPassword(email: email),
            onLogin: (loginData) => model.loginEmailPassword(
              email: loginData.name,
              password: loginData.password,
            ),
            loginProviders: <LoginProvider>[
              LoginProvider(
                button: Buttons.googleDark,
                label: 'Sign In with Google',
                callback: () => model.googleSignIn(),
              ),
              if (Platform.isIOS) ...[
                LoginProvider(
                  button: Buttons.appleDark,
                  label: 'Sign In with Apple',
                  callback: () => model.appleSignIn(),
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}
