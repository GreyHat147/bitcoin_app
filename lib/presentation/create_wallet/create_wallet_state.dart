class CreateWalletState {
  final String? mnemonic;
  final bool seedSaved;
  CreateWalletState({
    this.mnemonic,
    this.seedSaved = false,
  });
}
