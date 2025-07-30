import 'package:flutter/material.dart';
import 'filtered_book_page.dart';

class ExplorePage extends StatelessWidget {
  final List<String> trendingTopics = [
    "#ProduktivityHacks", "#MentalHealth", "#HistoricalFiction", "#Ai&Technology", "#MindFulness"
  ];

  final List<Map<String, dynamic>> authors = [
    {'name': 'Tere Liye', 'books': 45},
    {'name': 'Dewi Lestari', 'books': 12},
    {'name': 'Andrea Hirata', 'books': 8},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: ListView(
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
                  Text("Jelajah", style: TextStyle(color: Colors.white, fontSize: 16)),
                  SizedBox(height: 4),
                  Text("Literary Insight", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Jelajahi dunia baru dalam setiap halaman", style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Tombol filter/sort
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Yuk Jelajahi Bukumu!", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildSquareButton("Rating Tinggi", Colors.deepPurple, () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_) => FilteredBookPage(sort: 'rating')));
                      }),
                      SizedBox(width: 12),
                      _buildSquareButton("Terbaru", Colors.pinkAccent, () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_) => FilteredBookPage(sort: 'latest')));
                      }),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      _buildSquareButton("Premium", Colors.blue, () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_) => FilteredBookPage(sort: 'views')));
                      }),
                      SizedBox(width: 12),
                      _buildSquareButton("E-book", Colors.teal, () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_) => FilteredBookPage(tipe: 'ebook')));
                      }),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Penulis Favorit
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Penulis Favorit", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Lihat Semua", style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: authors.length,
                separatorBuilder: (context, _) => SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final author = authors[index];
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue,
                        child: Text("👩", style: TextStyle(fontSize: 24)),
                      ),
                      SizedBox(height: 4),
                      Text(author['name'], style: TextStyle(fontSize: 12)),
                      Text("${author['books']} Buku", style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  );
                },
              ),
            ),

            SizedBox(height: 24),

            // Topik Trending
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text("Topik Trending", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: trendingTopics.map((topic) {
                  return ActionChip(
                    label: Text(topic),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (_) => FilteredBookPage(genre: topic)));
                    },
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareButton(String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 100,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
          alignment: Alignment.center,
          child: Text(label, textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      ),
    );
  }
}
