import 'package:crypto_app/data/crypto_service.dart';
import 'package:crypto_app/presenter/bloc/crypto_event.dart';
import 'package:crypto_app/presenter/bloc/crypto_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final CryptoService service = CryptoService();

  CryptoBloc() : super(CryptoInitial()) {
    on<CryptoLoad>((event, emit) async {
      emit(CryptoLoading());
      await emit.forEach(
        service.getAll(),
        onData: (either) {
          return either.fold(
            (error) => CryptoError(error),
            (crypto) => CryptoLoaded(crypto),
          );
        },
        onError: (error, stackTrace) {
          return CryptoError(error.toString());
        },
      );
    });
  }
  void disconnect() => service.disconnect();
}
