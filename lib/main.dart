import 'package:flutter/material.dart';
import '../screens/login_screen.dart';
import '../screens/main_screen.dart';
import '../screens/card_screen.dart';
import '../screens/setting_screen.dart';
import '../screens/signup_screen.dart';

void main() {
  runApp(MaterialApp(
      initialRoute: 'loginScreen',
      routes: {
        'mainScreen': (context) => const MainScreen(),
        'signupScreen': (context) => const SignupScreen(),
        'settingScreen': (context) => const SettingScreen(),
        'loginScreen': (context) => const LoginScreen(),
        'cardScreen': (context) => const CardScreen()
      },
      debugShowCheckedModeBanner: false,
      title: "CBE",
      theme: ThemeData(),
     ));
}
