import 'product.dart';

class Products {
  List<Product> products;
  int total;
  int skip;
  int limit;

  Products({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        products: (json['products'] as List)
            .map((item) => Product.fromJson(item))
            .toList(),
        total: json['total'],
        skip: json['skip'],
        limit: json['limit'],
      );

  Map<String, dynamic> toJson() => {
        'products': products.map((e) => e.toJson()).toList(),
        'total': total,
        'skip': skip,
        'limit': limit,
      };
}
