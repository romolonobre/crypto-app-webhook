// ignore_for_file: public_member_api_docs, sort_constructors_first
// crypto_service.dart
import 'package:crypto_app/data/crypto_datasource.dart';
import 'package:either_dart/either.dart';

import 'crypto.dart';

class CryptoService {
  final CryptoDatasource _datasource = CryptoDatasource();
  CryptoService();

  Stream<Either<String, Crypto>> getAll() {
    try {
      final stream = _datasource.streamCrypto();

      return stream.map<Either<String, Crypto>>((crypto) {
        return Right(crypto);
      });
    } catch (e) {
      return Stream.value(Left(e.toString()));
    }
  }

  void disconnect() => _datasource.disconnect();
}
