import 'dart:typed_data';

import 'package:bitcoin_app/services/bitcoin.dart';
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Bitcoin Service", () {
    group("bip39", () {
      test("should generate a mnemonic", () {
        //Arrange
        IBitcoinService bitcoinSevice = BitcoinSevice();
        //Act
        final String mnemonic = bitcoinSevice.generateMnemonic();
        //Assert
        expect(mnemonic, isA<String>());
      });

      test("should validate a valid mnemonic", () {
        //Arrange
        IBitcoinService bitcoinSevice = BitcoinSevice();
        //Act
        final String mnemonic = bitcoinSevice.generateMnemonic();
        final bool isValid = bitcoinSevice.validateMnemonic(mnemonic);
        //Assert
        expect(isValid, isTrue);
      });

      test("should validate a invalid mnemonic", () {
        //Arrange
        IBitcoinService bitcoinSevice = BitcoinSevice();
        //Act
        const String mnemonic = "invalid";
        final bool isValid = bitcoinSevice.validateMnemonic(mnemonic);
        //Assert
        expect(isValid, isFalse);
      });
    });

    group("hdwallet", () {
      test("should create a HDWallet from a seed", () {
        //Arrange
        IBitcoinService bitcoinSevice = BitcoinSevice();
        //Act
        final String mnemonic = bitcoinSevice.generateMnemonic();

        var seed = bitcoinSevice.mnemonicToSeed(mnemonic);
        final HDWallet wallet = bitcoinSevice.createHDWallet(seed);

        //Assert
        expect(wallet, isA<HDWallet>());
      });
    });
  });
}
