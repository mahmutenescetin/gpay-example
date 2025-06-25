import 'package:flutter/material.dart';
import '../../../models/enums/category.dart';

class SearchFilterSection extends StatelessWidget {
  final TextEditingController searchController;
  final String searchQuery;
  final Category? selectedCategory;
  final List<Category> availableCategories;
  final Function(String) onSearchChanged;
  final Function(Category?) onCategoryChanged;
  final VoidCallback onClearFilters;
  final int filteredProductCount;
  final int totalProductCount;

  const SearchFilterSection({
    super.key,
    required this.searchController,
    required this.searchQuery,
    required this.selectedCategory,
    required this.availableCategories,
    required this.onSearchChanged,
    required this.onCategoryChanged,
    required this.onClearFilters,
    required this.filteredProductCount,
    required this.totalProductCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[50],
      child: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Ürün ara...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();
                        onSearchChanged('');
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 12),

          if (availableCategories.isNotEmpty) ...[
            Row(
              children: [
                const Text(
                  'Kategori: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FilterChip(
                          label: const Text('Tümü'),
                          selected: selectedCategory == null,
                          onSelected: (selected) {
                            onCategoryChanged(null);
                          },
                        ),
                        const SizedBox(width: 8),

                        ...availableCategories.map((category) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: Text(_getCategoryDisplayName(category)),
                              selected: selectedCategory == category,
                              onSelected: (selected) {
                                onCategoryChanged(category);
                              },
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],

          if (totalProductCount > 0) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$filteredProductCount ürün bulundu',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                if (searchQuery.isNotEmpty || selectedCategory != null)
                  TextButton(
                    onPressed: onClearFilters,
                    child: const Text('Filtreleri Temizle'),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _getCategoryDisplayName(Category category) {
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
}
