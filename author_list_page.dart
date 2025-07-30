import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'author_detail_page.dart';

class AuthorListPage extends StatefulWidget {
  @override
  State<AuthorListPage> createState() => _AuthorListPageState();
}

class _AuthorListPageState extends State<AuthorListPage> {
  List<dynamic> authors = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchAuthors();
  }

  Future<void> fetchAuthors() async {
    final res = await http.get(Uri.parse('http://192.168.56.1:8000/api/authors'));
    final data = json.decode(res.body);
    if (data['success']) {
      setState(() {
        authors = data['authors'];
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Penulis')),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: authors.length,
              itemBuilder: (context, index) {
                final author = authors[index];
                return ListTile(
                  leading: CircleAvatar(child: Text(author['nama_penulis'][0])),
                  title: Text(author['nama_penulis']),
                  subtitle: Text('ID: ${author['id_penulis']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AuthorDetailPage(authorId: author['id_penulis'])),
                    );
                  },
                );
              },
            ),
    );
  }
}
