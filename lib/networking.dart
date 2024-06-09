import 'dart:convert';

import 'package:http/http.dart' as http;

class Networking {
  // POST GET PUT DELETE
  // POST: https://myapi.com/products
  // Create Read Update Delete
  // CRUD

  Future<List<Product>> getProducts() async {
    try {
      final uri = Uri.parse('https://myapi.com/products/239238');

      final response = await http.post(
        uri,
        body: jsonEncode({'name': 'Gel2'}),
        headers: {'Authorization': 'Bearer asd9f0asjdf09wjef0w9ejfw09f'},
      );
      if (response.statusCode != 200) {
        throw Exception('something went wrong');
      }
      final productsData = jsonDecode(response.body) as List;

      final products = productsData.map((productData) {
        return Product(
          name: productData['name'] as String,
          price: productData['price'] as double,
        );
      }).toList();

      return products;
    } catch (e) {
      rethrow;
    }
  }
}

class Product {
  const Product({required this.name, required this.price});

  final String name;
  final double price;
}
