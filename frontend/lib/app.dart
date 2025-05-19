import 'package:flutter/material.dart';
import 'package:flutter_vto_project/utils/themes/theme.dart';
import 'package:flutter_vto_project/features/auth/screens/login/login_page.dart'; // Make sure path is correct

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: const LoginScreen(), // 👈 Show login screen after splash
    );
  }
}
