import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../services/api_config.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final title = TextEditingController();
  final desc = TextEditingController();
  bool _loading = false;

  Future<void> addBook() async {
    setState(() { _loading = true; });
    await http.post(Uri.parse('${ApiConfig.baseUrl}books/add'), body: {
      'judul': title.text.trim(),
      'id_penulis': '1', // contoh, sesuaikan
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Buku')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: title, decoration: const InputDecoration(labelText: 'Judul')),
            TextField(controller: desc, decoration: const InputDecoration(labelText: 'Deskripsi')),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : addBook,
              child: _loading ? const CircularProgressIndicator(color: Colors.white) : const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
