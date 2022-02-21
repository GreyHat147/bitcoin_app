class RecoverWalletState {
  final String? mnemonic;
  final bool invalidMnemonic;
  final bool walletRecovered;

  RecoverWalletState({
    this.mnemonic,
    this.invalidMnemonic = false,
    this.walletRecovered = false,
  });
}
