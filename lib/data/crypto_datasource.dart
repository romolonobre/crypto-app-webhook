import 'dart:convert';

import 'package:crypto_app/data/crypto.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CryptoDatasource {
  final String _url = 'wss://ws-feed.exchange.coinbase.com';
  late WebSocketChannel _channel;

  void _connect() {
    _channel = WebSocketChannel.connect(Uri.parse(_url));
    _subscribeToChannel(['BTC-USD', 'ETH-USD', 'LTC-USD']);
  }

  void _subscribeToChannel(List<String> productIds) {
    final subscribeMessage = {
      "type": "subscribe",
      "channels": [
        {
          "name": "ticker",
          "product_ids": productIds,
        }
      ]
    };

    _channel.sink.add(jsonEncode(subscribeMessage));
  }

  void disconnect() {
    _channel.sink.close();
  }

  Stream<Crypto> streamCrypto() {
    try {
      _connect();
      return _channel.stream.map<Crypto>((rowData) {
        final data = jsonDecode(rowData);
        final crypto = Crypto.fromMap(data);

        return crypto;
      });
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }
}
