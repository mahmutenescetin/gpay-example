import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_view/home_view.dart';
import '../home_view/home_view_model.dart';
import '../profile_view/profile_view.dart';
import '../transaction_view/transaction_view.dart';
import 'dashboard_view_model.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final List<Widget> _screens = [
    const HomeView(),
    const ProfileView(),
    const TransactionView(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dashboardViewModel = context.read<DashboardViewModel>();
      final homeViewModel = context.read<HomeViewModel>();
      dashboardViewModel.loadDataOnce(homeViewModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
      builder: (context, dashboardViewModel, child) {
        return Scaffold(
          body: _screens[dashboardViewModel.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: dashboardViewModel.currentIndex,
            onTap: (index) {
              dashboardViewModel.setCurrentIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet),
                label: 'Cüzdan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag),
                label: 'Ürünler',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long),
                label: 'İşlemler',
              ),
            ],
          ),
        );
      },
    );
  }
}
