import 'dart:typed_data';

// ignore: import_of_legacy_library_into_null_safe
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitcoin_app/services/services.dart';
import 'package:bitcoin_app/presentation/create_wallet/create_wallet_state.dart';

CreateWalletState _initial = CreateWalletState();

class CreateWalletCubit extends Cubit<CreateWalletState> {
  CreateWalletCubit() : super(_initial) {
    generateMnemonic();
  }

  final BitcoinSevice bitcoinSevice = BitcoinSevice();
  final StorageService storageService = StorageService();

  void generateMnemonic() {
    String nmemonic = bitcoinSevice.generateMnemonic();

    emit(CreateWalletState(mnemonic: nmemonic));
  }

  void saveNnemomic() {
    if (state.mnemonic == null) return;

    if (bitcoinSevice.validateMnemonic(state.mnemonic!)) {
      _createHDWallet();
    }
  }

  void _createHDWallet() async {
    Uint8List seed = bitcoinSevice.mnemonicToSeed(state.mnemonic!);
    HDWallet wallet = bitcoinSevice.createHDWallet(seed);

    String bitcoinAddress = bitcoinSevice.generateTesnetAddress(wallet.wif);

    await storageService.saveVal('seed', state.mnemonic!);
    await storageService.saveVal('address', bitcoinAddress);

    emit(
      CreateWalletState(mnemonic: state.mnemonic!, walletCreated: true),
    );
  }
}
