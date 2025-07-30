import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'book_detail_page.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<dynamic> favoriteBooks = [];
  bool loading = true;
  int? userId;

  @override
  void initState() {
    super.initState();
    loadUserAndFetchFavorites();
  }

  Future<void> loadUserAndFetchFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    var user = jsonDecode(prefs.getString('user')!);
    userId = user['id_user'];
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    if (userId == null) return;
    setState(() => loading = true);

    final res = await http.get(
      Uri.parse('http://192.168.56.1:8000/api/favorite/list/$userId'),
    );

    final data = json.decode(res.body);
    if (data['success']) {
      setState(() {
        favoriteBooks = data['favorites'];
        loading = false;
      });
    } else {
      setState(() {
        favoriteBooks = [];
        loading = false;
      });
    }
  }

  Future<void> removeFavorite(int bookId) async {
    final res = await http.post(
      Uri.parse('http://192.168.56.1:8000/api/favorite/remove'),
      body: {'user_id': userId.toString(), 'book_id': bookId.toString()},
    );
    final data = json.decode(res.body);
    if (data['success']) {
      fetchFavorites();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: loading
          ? Center(child: CircularProgressIndicator())
          : favoriteBooks.isEmpty
              ? Center(child: Text("Belum ada buku favorit"))
              : ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    // Header
                    Container(
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
                          Text("Favorit",
                              style: TextStyle(color: Colors.white70, fontSize: 14)),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Literary Insight",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(Icons.favorite, color: Colors.white, size: 26),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text("Pilih Buku Favoritmu",
                              style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),

                    SizedBox(height: 20),

                    ...favoriteBooks.asMap().entries.map((entry) {
                      int index = entry.key;
                      var book = entry.value;
                      String imgUrl =
                          'http://192.168.56.1:8000/storage/buku_images/${book['image']}';

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Nomor Avatar
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.indigo,
                              child: Text('${index + 1}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(width: 12),

                            // Info Buku + cover
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BookDetailPage(book: book),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.network(imgUrl, width: 40, height: 60, fit: BoxFit.cover),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(book['judul'] ?? '',
                                                style: TextStyle(fontWeight: FontWeight.bold)),
                                            SizedBox(height: 4),
                                            Text('Rating: ${book['rating'] ?? "-"}',
                                                style: TextStyle(
                                                    color: Colors.grey[600], fontSize: 13)),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.favorite, color: Colors.red, size: 20),
                                        onPressed: () {
                                          removeFavorite(book['id_buku']);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList()
                  ],
                ),
    );
  }
}
