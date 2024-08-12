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
    bloc.add(CryptoLoad());
  }

  @override
  void dispose() {
    super.dispose();
    bloc.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state is CryptoLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CryptoError) {
          return Center(
            child: Center(
              child: Text(state.message),
            ),
          );
        }
        if (state is CryptoLoaded) {
          return Center(
            child: Text(state.crypto.price ?? 'No info'),
          );
        }
        return const Text("No data available");
      },
    ));
  }
}
