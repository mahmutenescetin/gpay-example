import 'package:flutter/material.dart';
import '../home_view/home_view_model.dart';

class DashboardViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  bool _isDataLoaded = false;
  bool _isLoading = false;
  String? _error;

  int get currentIndex => _currentIndex;
  bool get isDataLoaded => _isDataLoaded;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> loadDataOnce(HomeViewModel homeViewModel) async {
    if (!_isDataLoaded) {
      _isLoading = true;
      _error = null;
      notifyListeners();

      try {
        await homeViewModel.getData();
        _isDataLoaded = true;
        _error = null;
      } catch (e) {
        _error = e.toString();
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void resetDataLoaded() {
    _isDataLoaded = false;
    notifyListeners();
  }
} 