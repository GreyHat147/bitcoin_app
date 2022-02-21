import 'package:flutter/material.dart';
import 'package:bitcoin_app/presentation/create_wallet/create_wallet_state.dart';
import 'package:bitcoin_app/ui/widgets/widgets.dart';
import 'package:bitcoin_app/presentation/create_wallet/create_wallet_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateWalletPage extends StatelessWidget {
  const CreateWalletPage({Key? key}) : super(key: key);

  void _onWalletCreated(BuildContext context) {
    SnackBar snackBar =
        const SnackBar(content: Text("Bitcoin Wallet created succesfully"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pushNamedAndRemoveUntil(context, "onboarding", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateWalletCubit(),
      child: BlocConsumer<CreateWalletCubit, CreateWalletState>(
        listener: (context, state) {
          if (state.walletCreated) _onWalletCreated(context);
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text("Create Wallet"),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (state.mnemonic == null)
                  const Center(
                    child: Text(
                      "Generate a new seed phrase",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                if (state.mnemonic != null) Mnemonic(mnemonic: state.mnemonic!),
                CustomButton(
                  onTap: context.read<CreateWalletCubit>().saveNnemomic,
                  text: "Save",
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: context.read<CreateWalletCubit>().generateMnemonic,
            child: const Icon(
              Icons.refresh,
              color: Colors.deepOrange,
            ),
            backgroundColor: Colors.white,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        ),
      ),
    );
  }
}

class Mnemonic extends StatelessWidget {
  const Mnemonic({required this.mnemonic, Key? key}) : super(key: key);

  final String mnemonic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            mnemonic,
            style: const TextStyle(fontSize: 45),
          ),
          const SizedBox(height: 20),
          const Divider(thickness: 1),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Save this phrase in a secure place",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
