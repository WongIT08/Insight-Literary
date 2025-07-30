import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'book_detail_page.dart';

class FilteredBookPage extends StatefulWidget {
  final String? genre;
  final String? sort;
  final String? tipe;

  FilteredBookPage({this.genre, this.sort, this.tipe});

  @override
  State<FilteredBookPage> createState() => _FilteredBookPageState();
}

class _FilteredBookPageState extends State<FilteredBookPage> {
  List<dynamic> books = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    final url = Uri.parse(
      'http://192.168.56.1:8000/api/books/filter?'
      'genre=${widget.genre ?? ''}&sort=${widget.sort ?? ''}&tipe=${widget.tipe ?? ''}'
    );
    final response = await http.get(url);
    final data = json.decode(response.body);
    if (data['success']) {
      setState(() {
        books = data['books'];
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = 'Hasil Pencarian';
    if (widget.genre != null && widget.genre!.isNotEmpty) title = 'Genre: ${widget.genre}';
    if (widget.sort == 'rating') title = 'Rating Tertinggi';
    if (widget.sort == 'latest') title = 'Terbaru';
    if (widget.sort == 'views') title = 'Paling Banyak Dibaca';
    if (widget.tipe == 'ebook') title = 'E-book';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : books.isEmpty
              ? Center(child: Text('Tidak ada buku ditemukan'))
              : GridView.builder(
                  padding: EdgeInsets.all(12),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    String imgUrl = 'http://192.168.56.1:8000/storage/buku_images/${book['image']}';
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => BookDetailPage(book: book)),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                image: DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(book['judul'] ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(height: 4),
                                  Text('Rating: ${book['rating'] ?? '-'}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
