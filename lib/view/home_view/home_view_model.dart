import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../repositories/product_repository.dart';

class HomeViewModel extends ChangeNotifier {
  static HomeViewModel? _instance;
  static HomeViewModel get instance {
    _instance ??= HomeViewModel._internal();
    return _instance!;
  }

  HomeViewModel._internal() : _repository = ProductRepository();

  final List<Product> _products = [];
  bool _isLoading = false;
  String? _error;
  final ProductRepository _repository;

  List<Product> get products => List.unmodifiable(_products);

  bool get isLoading => _isLoading;

  String? get error => _error;

  double get totalBalance {
    return _products.fold(0.0, (sum, product) => sum + product.price);
  }

  double get discountedTotalBalance {
    return _products.fold(0.0, (sum, product) {
      final discount = product.price * (product.discountPercentage / 100);
      return sum + (product.price - discount);
    });
  }

  double get totalDiscount {
    return _products.fold(0.0, (sum, product) {
      return sum + (product.price * (product.discountPercentage / 100));
    });
  }

  Future<void> getData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final fetched = await _repository.getProducts();
      _products.clear();
      _products.addAll(fetched.products);
    } catch (e) {
      _error = e.toString();
      print('Hata: $_error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
