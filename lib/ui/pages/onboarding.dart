import 'package:bitcoin_app/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  void _goToHome(BuildContext context) async {
    await context.read<OnboardingCubit>().clearData();
    Navigator.pushReplacementNamed(context, "home");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: BlocBuilder<OnboardingCubit, OnBoardingState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text("Bitcoin Wallet"),
            actions: [
              IconButton(
                onPressed: () => _goToHome(context),
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    'assets/BitcoinLogo.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                if (state.address != null)
                  Expanded(
                    child: Text(
                      state.address!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
