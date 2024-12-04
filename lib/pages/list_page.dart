// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../services/api_service.dart';
import 'detail_page.dart';

class ListPage extends StatefulWidget {
  final String category; // Tambahkan properti kategori

  const ListPage({super.key, required this.category}); // Pastikan kategori diterima

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Future<List<Book>> books;

  @override
  void initState() {
    super.initState();
    fetchBooks(widget.category); // Gunakan kategori dari widget
  }

  // Ambil daftar buku dari API berdasarkan kategori
  void fetchBooks(String category) {
    books = ApiService.fetchBooks(category).then(
      (data) => data.map((item) => Book.fromJson(item)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NY Times: ${widget.category}')), // Tampilkan nama kategori
      body: FutureBuilder<List<Book>>(
        future: books,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No books found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final book = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    // Gunakan coverImageUrl untuk gambar buku
                    leading: Image.network(
                      book.coverImageUrl,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 75,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.book, size: 50), // Placeholder jika gagal
                    ),
                    title: Text(book.title),
                    subtitle: Text('by ${book.author}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(book: book),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
