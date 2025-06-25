import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../models/enums/category.dart';
import '../home_view/home_view_model.dart';

class ProfileViewModel extends ChangeNotifier {
  final List<Product> _filteredProducts = [];
  String _searchQuery = '';
  Category? _selectedCategory;
  final HomeViewModel _homeViewModel;

  ProfileViewModel({HomeViewModel? homeViewModel})
    : _homeViewModel = homeViewModel ?? HomeViewModel.instance;

  List<Product> get allProducts => _homeViewModel.products;

  List<Product> get filteredProducts => List.unmodifiable(_filteredProducts);

  bool get isLoading => _homeViewModel.isLoading;

  String? get error => _homeViewModel.error;

  String get searchQuery => _searchQuery;

  Category? get selectedCategory => _selectedCategory;

  List<Category> get availableCategories {
    final categories = allProducts.map((p) => p.category).toSet().toList();
    categories.sort((a, b) => a.name.compareTo(b.name));
    return categories;
  }

  double get minPrice => allProducts.isEmpty
      ? 0
      : allProducts.map((p) => p.price).reduce((a, b) => a < b ? a : b);

  double get maxPrice => allProducts.isEmpty
      ? 0
      : allProducts.map((p) => p.price).reduce((a, b) => a > b ? a : b);

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void setSelectedCategory(Category? category) {
    _selectedCategory = category;
    _applyFilters();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = null;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredProducts.clear();

    for (final product in allProducts) {
      bool matchesSearch =
          _searchQuery.isEmpty ||
          product.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.description.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          product.brand?.toLowerCase().contains(_searchQuery.toLowerCase()) ==
              true;

      bool matchesCategory =
          _selectedCategory == null || product.category == _selectedCategory;

      if (matchesSearch && matchesCategory) {
        _filteredProducts.add(product);
      }
    }

    notifyListeners();
  }

  void clearError() {
    _homeViewModel.clearError();
  }

  void refreshFilters() {
    _applyFilters();
  }
}
