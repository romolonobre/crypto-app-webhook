import 'dart:async';

import 'package:crypto_app/data/crypto_service.dart';
import 'package:crypto_app/presenter/bloc/crypto_event.dart';
import 'package:crypto_app/presenter/bloc/crypto_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final CryptoService service = CryptoService();

  CryptoBloc() : super(CryptoInitialState()) {
    on<CryptoLoadEvent>(getCrypto);
  }

  FutureOr<void> getCrypto(CryptoLoadEvent event, Emitter<CryptoState> emit) async {
    emit(CryptoLoadingState());
    await emit.forEach(
      service.getAll(),
      onData: (either) {
        return either.fold(
          (error) => CryptoErrorState(error),
          (crypto) => CryptoLoadedState(crypto),
        );
      },
      onError: (error, stackTrace) {
        return CryptoErrorState(error.toString());
      },
    );
  }

  void disconnect() => service.disconnect();
}
