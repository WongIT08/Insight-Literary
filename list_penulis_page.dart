import 'package:flutter/material.dart';
import '../../models/penulis.dart';
import '../../services/api_config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListPenulisPage extends StatefulWidget {
  const ListPenulisPage({super.key});

  @override
  State<ListPenulisPage> createState() => _ListPenulisPageState();
}

class _ListPenulisPageState extends State<ListPenulisPage> {
  List<Penulis> penulisList = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    fetchPenulis();
  }

  Future<void> fetchPenulis() async {
    setState(() => _loading = true);
    try {
      final res = await http.get(Uri.parse('${ApiConfig.baseUrl}penulis'));
      final data = json.decode(res.body);
      setState(() {
        penulisList = (data['data'] as List).map((e) => Penulis.fromJson(e)).toList();
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('✍️ Daftar Penulis', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : penulisList.isEmpty
              ? const Center(child: Text('Belum ada data penulis'))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: penulisList.length,
                  itemBuilder: (_, i) {
                    final p = penulisList[i];
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: CircleAvatar(
                          backgroundColor: Colors.deepPurple.shade100,
                          child: const Icon(Icons.person, color: Colors.deepPurple),
                        ),
                        title: Text(
                          p.namaPenulis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: p.profil.isNotEmpty ? Text(p.profil) : null,
                      ),
                    );
                  },
                ),
    );
  }
}
