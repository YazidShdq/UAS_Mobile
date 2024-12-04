// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiKey = 'O2EmbZxRvU73uJMU5Jsiz2SYDPMsnbpi';
  static const String _baseUrl = 'https://api.nytimes.com/svc/books/v3';

  // Fungsi untuk mengambil daftar buku berdasarkan kategori
  static Future<List<dynamic>> fetchBooks(String category) async {
    final url = Uri.parse('$_baseUrl/lists.json?api-key=$_apiKey&list=$category');
    final response = await http.get(url);

    // Debugging: cetak status code dan respons body
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results']; // Mengembalikan daftar buku
    } else {
      throw Exception('Failed to load books');
    }
  }
}
