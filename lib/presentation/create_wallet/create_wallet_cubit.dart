import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitcoin_app/services/services.dart';
import 'package:bitcoin_app/presentation/create_wallet/create_wallet_state.dart';

CreateWalletState _initial = CreateWalletState();

class CreateWalletCubit extends Cubit<CreateWalletState> {
  CreateWalletCubit() : super(_initial) {
    generateMnemonic();
  }

  final BitcoinSevice bitcoinSevice = BitcoinSevice();

  void generateMnemonic() {
    String nmemonic = bitcoinSevice.generateMnemonic();

    emit(CreateWalletState(mnemonic: nmemonic));

    print("nmemonic $nmemonic");
  }
}
