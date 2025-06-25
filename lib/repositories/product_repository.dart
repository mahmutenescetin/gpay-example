import '../models/products.dart';
import '../services/api_service.dart';

class ProductRepository {
  final ApiService _apiService;

  ProductRepository({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  Future<Products> getProducts() async {
    try {
      return await _apiService.fetchNotes();
    } catch (e) {
      throw Exception('Ürünler yüklenirken hata oluştu: $e');
    }
  }
}
