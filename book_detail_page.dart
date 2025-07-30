import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookDetailPage extends StatefulWidget {
  final Map<String, dynamic> book;

  BookDetailPage({required this.book});

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  bool loading = false;

  Future<void> addToFavorite() async {
    setState(() => loading = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      var user = jsonDecode(prefs.getString('user')!);
      int userId = user['id_user'];

      final res = await http.post(
        Uri.parse('http://192.168.56.1:8000/api/favorite/add'),
        body: {
          'user_id': userId.toString(),
          'book_id': widget.book['id_buku'].toString(),
        },
      );
      final data = json.decode(res.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'] ?? 'Gagal menambahkan ke favorit')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $e')),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    String? image = widget.book['image'];
    String imageUrl = image != null && image.isNotEmpty
        ? 'http://192.168.56.1:8000/storage/buku_images/$image'
        : '';

    return Scaffold(
      appBar: AppBar(title: Text(widget.book['judul'] ?? 'Detail Buku')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imageUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      height: 200,
                      color: Colors.grey.shade300,
                      alignment: Alignment.center,
                      child: Icon(Icons.image, size: 80, color: Colors.grey),
                    ),
              SizedBox(height: 16),

              Text(widget.book['judul'] ?? '-', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Genre: ${widget.book['genre'] ?? '-'}'),
              Text('Rating: ${widget.book['rating'] ?? '-'}'),
              SizedBox(height: 12),
              Text('Deskripsi:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(widget.book['deskripsi'] ?? '-', textAlign: TextAlign.justify),

              SizedBox(height: 24),

              // ✅ Tombol tambah ke favorit dengan loading
              ElevatedButton.icon(
                onPressed: loading ? null : addToFavorite,
                icon: loading
                    ? SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Icon(Icons.favorite_border),
                label: Text('Tambahkan ke Favorit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
