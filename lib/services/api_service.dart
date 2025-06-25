import 'package:dio/dio.dart';

import '../models/products.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Products> fetchNotes() async {
    final response = await _dio.get('https://dummyjson.com/products');

    final data = response.data as Map<String, dynamic>;

    return Products.fromJson(data);
  }
}
