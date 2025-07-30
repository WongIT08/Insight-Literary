import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'book_detail_page.dart';
import 'filtered_book_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> books = [];
  List<dynamic> trendingBooks = [];
  bool loading = true;
  bool error = false;

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    try {
      final res = await http.get(Uri.parse('http://192.168.56.1:8000/api/books'));
      final data = json.decode(res.body);
      if (data['success']) {
        setState(() {
          books = data['books'];
          trendingBooks = data['books'].take(3).toList();
          loading = false;
        });
      } else {
        setState(() {
          error = true;
          loading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = true;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: loading
          ? Center(child: CircularProgressIndicator())
          : error
              ? Center(child: Text('❌ Gagal memuat data'))
              : SafeArea(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildHeader(),
                      SizedBox(height: 16),
                      _buildSearchBox(),
                      SizedBox(height: 16),
                      _buildGenreChips(),
                      SizedBox(height: 16),
                      _buildSectionTitle('Rekomendasi Untukmu'),
                      SizedBox(height: 8),
                      _buildBookGrid(),
                      SizedBox(height: 20),
                      _buildSectionTitle('Trending Minggu Ini'),
                      SizedBox(height: 8),
                      _buildTrendingList(),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Selamat Datang di", style: TextStyle(fontSize: 14, color: Colors.white70)),
                  SizedBox(height: 4),
                  Text("Literary Insight", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
              Icon(Icons.notifications_none, color: Colors.white, size: 26),
            ],
          ),
          SizedBox(height: 16),
          Text("Temukan Buku Favoritmu!", style: TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Cari judul buku, penulis, atau genre...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildGenreChips() {
    final genres = ['Semua', 'Fiksi', 'Non-Fiksi', 'Romance', 'Misteri'];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        children: genres.map((genre) {
          return ActionChip(
            label: Text(genre),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FilteredBookPage(genre: genre == 'Semua' ? '' : genre)),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildBookGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: books.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) {
          final book = books[index];
          final imgUrl = 'http://192.168.56.1:8000/storage/buku_images/${book['image']}';
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BookDetailPage(book: book)),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        image: DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(book['judul'] ?? '', style: TextStyle(fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                    Text('Rating: ${book['rating'] ?? '-'}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrendingList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: Column(
        children: trendingBooks.asMap().entries.map((entry) {
          int index = entry.key;
          var book = entry.value;
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigo,
              child: Text('${index + 1}', style: TextStyle(color: Colors.white)),
            ),
            title: Text(book['judul'] ?? ''),
            subtitle: Text('Rating: ${book['rating'] ?? '-'}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BookDetailPage(book: book)),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
