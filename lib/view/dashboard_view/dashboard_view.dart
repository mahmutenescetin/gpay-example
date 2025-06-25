import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_view/home_view.dart';
import '../home_view/home_view_model.dart';
import '../profile_view/profile_view.dart';
import '../transaction_view/transaction_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _currentIndex = 0;
  bool _isDataLoaded = false;

  final List<Widget> _screens = [
    const HomeView(),
    const ProfileView(),
    const TransactionView(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDataOnce();
    });
  }

  void _loadDataOnce() {
    if (!_isDataLoaded) {
      final homeViewModel = context.read<HomeViewModel>();
      homeViewModel.getData().then((_) {
        _isDataLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
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
  }
}
