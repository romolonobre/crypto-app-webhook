import 'dart:convert';

import 'package:crypto_app/data/crypto.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CriptoDatasource {
  final String _url = 'wss://ws-feed.exchange.coinbase.com';
  late WebSocketChannel _channel;

  void connect() {
    _channel = WebSocketChannel.connect(Uri.parse(_url));
    _subscribeToChannel(['BTC-USD', 'ETH-USD', 'LTC-USD']);
  }

  void _subscribeToChannel(List<String> productIds) {
    final subscribeMessage = {
      "type": "subscrib",
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
      connect();
      return _channel.stream.map<Crypto>((rowData) {
        final data = jsonDecode(rowData);
        final ticker = Crypto.fromMap(data);

        return ticker;
      });
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }
}
