import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bitcoin_app/presentation/presentation.dart';
import 'package:bitcoin_app/services/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:bip39/bip39.dart' as bip39;

RecoverWalletState _initial = RecoverWalletState();

class RecoverWalletCubit extends Cubit<RecoverWalletState> {
  RecoverWalletCubit() : super(_initial);

  final StorageService _storageService = StorageService();
  final BitcoinSevice bitcoinSevice = BitcoinSevice();

  void recover() async {
    if (state.mnemonic != null) {
      String bitcoinAddress = bitcoinSevice.importMnemonic(state.mnemonic!);

      await _storageService.saveVal('seed', state.mnemonic!);
      await _storageService.saveVal('address', bitcoinAddress);

      emit(
        RecoverWalletState(mnemonic: state.mnemonic, walletRecovered: true),
      );
    } else {
      emit(
        RecoverWalletState(mnemonic: state.mnemonic, invalidMnemonic: true),
      );
    }
  }

  void setMnemonic(String? mnemonic) {
    if (mnemonic == null || mnemonic.isEmpty) return;
    emit(RecoverWalletState(mnemonic: mnemonic));
  }
}
