import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bitcoin_app/presentation/presentation.dart';
import 'package:bitcoin_app/services/services.dart';
// ignore: import_of_legacy_library_into_null_safe

OnBoardingState _initial = OnBoardingState();

class OnboardingCubit extends Cubit<OnBoardingState> {
  OnboardingCubit() : super(_initial) {
    _getCurrentAddress();
  }

  final StorageService _storageService = StorageService();

  Future<void> clearData() async {
    await _storageService.secureStorage.deleteAll();
  }

  Future<void> _getCurrentAddress() async {
    final String? val = await _storageService.getValue('address');
    if (val != null) {
      emit(OnBoardingState(address: val));
    }
  }
}
