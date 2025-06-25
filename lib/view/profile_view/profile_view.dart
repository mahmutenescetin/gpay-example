import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profile_view_model.dart';
import 'widgets/search_filter_section.dart';
import 'widgets/product_card.dart';
import 'widgets/loading_widget.dart';
import 'widgets/error_widget.dart';
import 'widgets/empty_state_widget.dart';
import '../home_view/home_view_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeViewModel = context.read<HomeViewModel>();
      final profileViewModel = context.read<ProfileViewModel>();

      if (homeViewModel.products.isNotEmpty) {
        profileViewModel.refreshFilters();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürünler'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () async {
              final homeViewModel = context.read<HomeViewModel>();
              final profileViewModel = context.read<ProfileViewModel>();
              await homeViewModel.getData();
              if (mounted) {
                profileViewModel.refreshFilters();
              }
            },
            icon: const Icon(Icons.refresh),
            tooltip: 'Yenile',
          ),
        ],
      ),
      body: Consumer2<HomeViewModel, ProfileViewModel>(
        builder: (context, homeViewModel, profileViewModel, child) {
          if (homeViewModel.isLoading) {
            return const LoadingWidget(message: 'Ürünler yükleniyor...');
          }

          if (homeViewModel.error != null) {
            return CustomErrorWidget(
              message: homeViewModel.error!,
              onRetry: () {
                homeViewModel.clearError();
                homeViewModel.getData().then((_) {
                  profileViewModel.refreshFilters();
                });
              },
            );
          }

          return Column(
            children: [
              SearchFilterSection(
                searchController: _searchController,
                searchQuery: profileViewModel.searchQuery,
                selectedCategory: profileViewModel.selectedCategory,
                availableCategories: profileViewModel.availableCategories,
                onSearchChanged: profileViewModel.setSearchQuery,
                onCategoryChanged: profileViewModel.setSelectedCategory,
                onClearFilters: profileViewModel.clearFilters,
                filteredProductCount: profileViewModel.filteredProducts.length,
                totalProductCount: homeViewModel.products.length,
              ),

              Expanded(
                child: profileViewModel.filteredProducts.isEmpty
                    ? const EmptyStateWidget(message: 'Ürün bulunamadı')
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: profileViewModel.filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product =
                              profileViewModel.filteredProducts[index];
                          return ProductCard(product: product);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
