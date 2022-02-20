import 'package:bitcoin_app/presentation/presentation.dart';
import 'package:bitcoin_app/ui/pages/create_wallet.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_app/ui/pages/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      home: const HomePage(),
      routes: {
        "create": (context) => const CreateWalletPage(),
      },
    );
  }
}
