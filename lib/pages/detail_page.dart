// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import '../models/book_model.dart';

class DetailPage extends StatelessWidget {
  final Book book;

  const DetailPage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          book.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.teal.shade700,
                  Colors.teal.shade100,
                ],
              ),
            ),
          ),
          // Konten detail buku
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gambar buku
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        book.coverImageUrl,
                        fit: BoxFit.cover,
                        width: 180,
                        height: 270,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.book, size: 150, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Kartu informasi buku + deskripsi
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Judul buku
                          Text(
                            book.title,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal.shade800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Penulis buku
                          Text(
                            'by ${book.author}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Informasi penerbit
                          Row(
                            children: [
                              const Icon(Icons.library_books_outlined,
                                  size: 20, color: Colors.teal),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Publisher: ${book.publisher}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Deskripsi buku
                          Text(
                            book.description,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              height: 1.5, // Menambah jarak antar baris
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Tombol aksi
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Tambahkan aksi, misalnya share atau bookmark
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Bookmarked: ${book.title}")),
                        );
                      },
                      icon: const Icon(Icons.bookmark),
                      label: const Text("Add to Bookmark"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade800,
                        padding:
                            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
