import 'package:bitcoin_app/presentation/presentation.dart';
import 'package:bitcoin_app/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecoverWalletPage extends StatelessWidget {
  const RecoverWalletPage({Key? key}) : super(key: key);

  void _onInvalidSeedPhrase(BuildContext context) {
    SnackBar snackBar = const SnackBar(content: Text("Invalid seed frase"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _onWalletRecovered(BuildContext context) {
    SnackBar snackBar =
        const SnackBar(content: Text("Bitcoin Wallet recovered succesfully"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pushNamedAndRemoveUntil(context, "onboarding", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecoverWalletCubit(),
      child: BlocConsumer<RecoverWalletCubit, RecoverWalletState>(
        listener: (context, state) {
          if (state.invalidMnemonic) _onInvalidSeedPhrase(context);
          if (state.walletRecovered) _onWalletRecovered(context);
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text("Recover Wallet"),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EditableMnemonic(state: state),
                  const SizedBox(height: 30),
                  CustomButton(
                    onTap: state.mnemonic != null
                        ? context.read<RecoverWalletCubit>().recover
                        : () {},
                    text: "Recover",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EditableMnemonic extends StatefulWidget {
  EditableMnemonic({required this.state, Key? key}) : super(key: key);

  final RecoverWalletState state;

  @override
  State<EditableMnemonic> createState() => _EditableMnemonicState();
}

class _EditableMnemonicState extends State<EditableMnemonic> {
  final TextEditingController _mnemonicCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _mnemonicCtrl,
            style: const TextStyle(fontSize: 45),
            maxLines: 10,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
              ),
              hintText: 'Enter your seed phrase please ...',
            ),
            onChanged: (String? val) {
              context.read<RecoverWalletCubit>().setMnemonic(val);
            },
          ),
        ],
      ),
    );
  }
}
