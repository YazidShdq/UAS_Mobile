// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 215, 202), // Warna latar belakang lembut
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 92, 132, 175), // Warna gelap untuk AppBar
        title: const Text('Yazid Bookpedia'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Tambahkan aksi untuk profil, jika diperlukan
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header dengan pencarian
              const Text(
                "Info buku apa yang kamu butuhkan?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  // TextField untuk pencarian
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Masukkan judul buku",
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Ikon mikrofon
                  IconButton(
                    icon: const Icon(Icons.mic),
                    onPressed: () {
                      // Aksi mikrofon
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Kategori Buku
              const Text(
                "Kategori Buku",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryItem(context, Icons.book, "Fiksi", "hardcover-fiction"),
                  _buildCategoryItem(context, Icons.menu_book, "Non-Fiksi", "hardcover-nonfiction"),
                  _buildCategoryItem(context, Icons.history_edu, "Biografi", "combined-print-and-e-book-nonfiction"),
                  _buildCategoryItem(context, Icons.science, "Sains", "science"),
                ],
              ),
              const SizedBox(height: 24),
              // Buku Populer
              const Text(
                "Buku Populer",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildPopularBookItem("https://covers.openlibrary.org/b/isbn/9780553391923-L.jpg", "A Girl's Guide"),
                    _buildPopularBookItem("https://covers.openlibrary.org/b/isbn/9780132350884-L.jpg", "Clean Code"),
                    _buildPopularBookItem("https://covers.openlibrary.org/b/isbn/9781491954249-L.jpg", "Design Patterns"),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Buku Terbaru
              const Text(
                "Buku Terbaru",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  _buildLatestBookItem(
                    context,
                    "The Pragmatic Programmer",
                    "Programming",
                    "https://covers.openlibrary.org/b/isbn/9780201616224-L.jpg",
                  ),
                  const SizedBox(height: 8),
                  _buildLatestBookItem(
                    context,
                    "Introduction to Algorithms",
                    "Education",
                    "https://covers.openlibrary.org/b/isbn/9780262033848-L.jpg",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk kategori
  Widget _buildCategoryItem(BuildContext context, IconData icon, String label, String category) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke ListPage dengan kategori
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListPage(category: category),
          ),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFF2D3E50),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // Widget untuk item buku populer
  Widget _buildPopularBookItem(String imageUrl, String title) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          color: Colors.black54,
          padding: const EdgeInsets.all(4),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  // Widget untuk item buku terbaru
  Widget _buildLatestBookItem(
      BuildContext context, String title, String category, String imageUrl) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: 50,
          height: 75,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.book),
        ),
        title: Text(title),
        subtitle: Text(category),
        trailing: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListPage(category: category)),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
          ),
          child: const Text("Baca Info"),
        ),
      ),
    );
  }
}
