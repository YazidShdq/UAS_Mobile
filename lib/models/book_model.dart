class Book {
  final String title;
  final String author;
  final String description;
  final String publisher;
  final String primaryIsbn13;

  // ignore: prefer_typing_uninitialized_variables
  var isbn; // Digunakan untuk membuat URL gambar

  Book({
    required this.title,
    required this.author,
    required this.description,
    required this.publisher,
    required this.primaryIsbn13,
  });

  // Parsing data JSON dari API NY Times Books
  factory Book.fromJson(Map<String, dynamic> json) {
    final bookDetails = json['book_details'][0];
    return Book(
      title: bookDetails['title'],
      author: bookDetails['author'],
      description: bookDetails['description'],
      publisher: bookDetails['publisher'],
      primaryIsbn13: bookDetails['primary_isbn13'],
    );
  }

  // Properti untuk menghasilkan URL gambar berdasarkan ISBN
  String get coverImageUrl =>
      'https://covers.openlibrary.org/b/isbn/$primaryIsbn13-L.jpg';
}
