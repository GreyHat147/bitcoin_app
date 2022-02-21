import 'dart:typed_data';

// ignore: import_of_legacy_library_into_null_safe
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;
import 'package:bitcoin_flutter/bitcoin_flutter.dart';

abstract class IBitcoinService {
  /// Returns a random mnemonic
  String generateMnemonic();

  /// Validates the mnemonic provided
  bool validateMnemonic(String mnemonic);

  Uint8List mnemonicToSeed(String mnemonic);

  HDWallet createHDWallet(Uint8List seed);

  String generateTesnetAddress(String wif);

  String importMnemonic(String mnemonic);
}

class BitcoinSevice implements IBitcoinService {
  @override
  String generateMnemonic() => bip39.generateMnemonic();

  @override
  bool validateMnemonic(String mnemonic) => bip39.validateMnemonic(mnemonic);

  @override
  Uint8List mnemonicToSeed(String mnemonic) => bip39.mnemonicToSeed(mnemonic);

  @override
  HDWallet createHDWallet(Uint8List seed) => HDWallet.fromSeed(seed);

  @override
  String generateTesnetAddress(String wif) {
    final testnetNetwork = testnet;
    final keyPair = ECPair.fromWIF(wif);
    final address = P2PKH(
      data: PaymentData(pubkey: keyPair.publicKey),
      network: testnetNetwork,
    ).data.address;
    return address;
  }

  @override
  String importMnemonic(String mnemonic) {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final node = bip32.BIP32.fromSeed(seed);
    return generateTesnetAddress(node.toWIF());
  }
}
