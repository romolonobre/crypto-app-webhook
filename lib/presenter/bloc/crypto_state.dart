// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../data/crypto.dart';

abstract class CryptoState {}

class CryptoInitialState extends CryptoState {}

class CryptoLoadingState extends CryptoState {}

class CryptoLoadedState extends CryptoState {
  final Crypto crypto;
  CryptoLoadedState(this.crypto);
}

class CryptoErrorState extends CryptoState {
  final String message;
  CryptoErrorState(this.message);
}
