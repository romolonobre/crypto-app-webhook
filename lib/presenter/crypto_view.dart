import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cripto_bloc.dart';
import 'bloc/crypto_event.dart';
import 'bloc/crypto_state.dart';

class CryptoView extends StatefulWidget {
  const CryptoView({super.key});

  @override
  State<CryptoView> createState() => _CryptoViewState();
}

class _CryptoViewState extends State<CryptoView> {
  final bloc = CryptoBloc();

  @override
  void initState() {
    super.initState();
    bloc.add(CryptoLoadEvent());
  }

  @override
  void dispose() {
    super.dispose();
    bloc.disconnect();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is CryptoLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CryptoErrorState) {
          return Center(
            child: Center(
              child: Text(state.message),
            ),
          );
        }
        if (state is CryptoLoadedState) {
          return Center(
            child: Text(state.crypto.price ?? 'No info'),
          );
        }
        return const Text("No data available");
      },
    ));
  }
}
