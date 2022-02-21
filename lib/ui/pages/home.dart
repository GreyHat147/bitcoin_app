import 'package:flutter/material.dart';
import 'package:bitcoin_app/ui/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _goToCreateWalletPage(BuildContext context) {
    Navigator.pushNamed(context, "create");
  }

  void _goToRecoveralletPage(BuildContext context) {
    Navigator.pushNamed(context, "recover");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bitcoin Wallet"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset('assets/BitcoinLogo.png'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  onTap: () {
                    _goToCreateWalletPage(context);
                  },
                  text: "Create Wallet",
                ),
                CustomButton(
                  onTap: () => _goToRecoveralletPage(context),
                  btnColor: Colors.black,
                  text: "Recover Wallet",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
