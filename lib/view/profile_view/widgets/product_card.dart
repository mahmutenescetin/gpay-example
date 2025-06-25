import 'package:flutter/material.dart';
import '../../../models/product.dart';
import 'product_detail_dialog.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => ProductDetailDialog(product: product),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  color: Colors.grey[100],
                ),
                child: product.thumbnail.isNotEmpty
                    ? ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.network(
                          product.thumbnail,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                color: Colors.grey[300],
                              ),
                              child: const Icon(
                                Icons.image,
                                size: 40,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          color: Colors.grey[300],
                        ),
                        child: const Icon(
                          Icons.image,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),

            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),

                    Expanded(
                      child: Text(
                        product.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(product.category),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _getCategoryDisplayName(product.category),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),

                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 12,
                              color: Colors.amber[600],
                            ),
                            Text(
                              ' ${product.rating.toStringAsFixed(1)}',
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        if (product.discountPercentage > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '-%${product.discountPercentage.toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCategoryDisplayName(dynamic category) {
    switch (category.toString()) {
      case 'Category.beauty':
        return 'Güzellik';
      case 'Category.fragrances':
        return 'Parfüm';
      case 'Category.furniture':
        return 'Mobilya';
      case 'Category.groceries':
        return 'Market';
      case 'Category.smartphones':
        return 'Telefon';
      case 'Category.laptops':
        return 'Laptop';
      case 'Category.homeDecoration':
        return 'Dekorasyon';
      case 'Category.skincare':
        return 'Cilt Bakımı';
      case 'Category.automotive':
        return 'Otomotiv';
      case 'Category.motorcycle':
        return 'Motosiklet';
      case 'Category.lighting':
        return 'Aydınlatma';
      default:
        return category.name;
    }
  }

  Color _getCategoryColor(dynamic category) {
    switch (category.toString()) {
      case 'Category.beauty':
        return Colors.pink;
      case 'Category.fragrances':
        return Colors.purple;
      case 'Category.furniture':
        return Colors.brown;
      case 'Category.groceries':
        return Colors.green;
      case 'Category.smartphones':
        return Colors.blue;
      case 'Category.laptops':
        return Colors.indigo;
      case 'Category.homeDecoration':
        return Colors.orange;
      case 'Category.skincare':
        return Colors.teal;
      case 'Category.automotive':
        return Colors.red;
      case 'Category.motorcycle':
        return Colors.deepOrange;
      case 'Category.lighting':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }
} 