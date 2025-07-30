import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthorDetailPage extends StatefulWidget {
  final int authorId;
  AuthorDetailPage({required this.authorId});

  @override
  State<AuthorDetailPage> createState() => _AuthorDetailPageState();
}

class _AuthorDetailPageState extends State<AuthorDetailPage> {
  Map<String, dynamic>? author;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchAuthor();
  }

  Future<void> fetchAuthor() async {
    final res = await http.get(Uri.parse('http://192.168.56.1:8000/api/author/${widget.authorId}'));
    final data = json.decode(res.body);
    if (data['success']) {
      setState(() {
        author = data['author'];
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Penulis')),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Text(author?['nama_penulis'] ?? '', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Jumlah buku: ${author?['books']?.length ?? 0}'),
                // List buku
                Expanded(
                  child: ListView(
                    children: (author?['books'] as List).map((book) {
                      return ListTile(
                        title: Text(book['judul']),
                        subtitle: Text('Genre: ${book['genre']}'),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
    );
  }
}
