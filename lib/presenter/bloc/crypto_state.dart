// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../data/crypto.dart';

abstract class CryptoState {}

class CryptoInitial extends CryptoState {}

class CryptoLoading extends CryptoState {}

class CryptoLoaded extends CryptoState {
  final Crypto crypto;
  CryptoLoaded(this.crypto);
}

class CryptoError extends CryptoState {
  final String message;
  CryptoError(this.message);
}
