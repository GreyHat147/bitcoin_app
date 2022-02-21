import 'package:flutter/material.dart';

import 'package:bitcoin_app/ui/pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitcoin Wallet',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      initialRoute: 'home',
      routes: {
        "home": (context) => const HomePage(),
        "create": (context) => const CreateWalletPage(),
        "onboarding": (context) => const OnboardingPage(),
        "recover": (context) => const RecoverWalletPage(),
      },
    );
  }
}
