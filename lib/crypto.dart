class Crypto {
  final String productId;
  final String? price;

  Crypto({required this.productId, required this.price});

  @override
  String toString() => 'Crypto(productId: $productId, price: $price)';

  factory Crypto.fromMap(dynamic map) {
    return Crypto(
      productId: map['product_id'],
      price: map['price'],
    );
  }
}
