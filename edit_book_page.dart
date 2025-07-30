import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../services/api_config.dart';

class EditBookPage extends StatefulWidget {
  final Map book;
  const EditBookPage({super.key, required this.book});

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  late TextEditingController title, desc;
  bool _loading = false;

  Future<void> updateBook() async {
    setState(() { _loading = true; });
    await http.post(Uri.parse('${ApiConfig.baseUrl}books/update'), body: {
      'id_buku': widget.book['id_buku'].toString(),
      'judul': title.text.trim(),
      'id_penulis': '1', // contoh
      'deskripsi': desc.text.trim(),
      'genre': 'Fiksi',
      'tipe': 'Novel',
      'rating': '4',
      'views': '0',
      'image': 'default.png',
    });
    setState(() { _loading = false; });
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.book['judul']);
    desc = TextEditingController(text: widget.book['deskripsi']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Buku')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: title, decoration: const InputDecoration(labelText: 'Judul')),
            TextField(controller: desc, decoration: const InputDecoration(labelText: 'Deskripsi')),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : updateBook,
              child: _loading ? const CircularProgressIndicator(color: Colors.white) : const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
