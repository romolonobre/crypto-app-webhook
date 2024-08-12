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
        body: BlocBuilder<CryptoBloc, CryptoState>(
      bloc: bloc,
      builder: (context, state) {
        return switch (state) {
          CryptoInitialState _ => SizedBox.fromSize(),
          CryptoLoadingState _ => const Center(child: CircularProgressIndicator()),
          CryptoLoadedState state => Center(child: Text(state.crypto.price ?? 'No info')),
          CryptoErrorState state => Center(child: Text(state.message)),
        };
      },
    ));
  }
}
