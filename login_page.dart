import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;

  Future<void> loginUser() async {
     String baseUrl;
  if (Platform.isAndroid) {
    // Jika dijalankan di emulator → pakai 10.0.2.2
    baseUrl = 'http://10.0.2.2:8000';
  } else {
    // Jika di HP asli → pakai IP LAN laptop
    baseUrl = 'http://192.168.56.1:8000'; // Ganti sesuai IP LAN laptop kamu
  }

  final response = await http.post(
    Uri.parse('$baseUrl/api/login/user'),
    body: {
      'username': usernameController.text.trim(),
      'password': passwordController.text.trim(),
    },
  );

    var data = json.decode(response.body);
    if (data['success']) {
      // ✅ Ambil data user dari backend
      var user = data['user'];

        // ✅ Simpan user ke shared_preferences
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('user', jsonEncode(user));

      // Navigate ke ProfilePage sambil kirim user
     Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (_) => BottomNavScreen()),
);

    } else {
      // Tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'] ?? 'Login gagal')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFA9C6D1),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🔵 Logo + Judul
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/Buku_biru.png', width: 36, height: 36),
                    const SizedBox(width: 8),
                    const Text(
                      "Literary Insight",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF264ECA),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  "Temukan Buku Favoritmu!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),

                const SizedBox(height: 24),

                // 🔵 Tab Masuk & Daftar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buttonTab(
                      text: "Masuk",
                      selected: true,
                      onTap: () {},
                    ),
                    const SizedBox(width: 50),
                    _buttonTab(
                      text: "Daftar",
                      selected: false,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RegisterPage()),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                _inputField(
                  label: "Username",
                  hint: "Masukkan username Anda",
                  controller: usernameController,
                ),
                const SizedBox(height: 16),
                _inputField(
                  label: "Password",
                  hint: "Password Anda",
                  controller: passwordController,
                  obscure: true,
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (val) {
                        setState(() {
                          rememberMe = val ?? false;
                        });
                      },
                    ),
                    const Text("Ingat Saya"),
                  ],
                ),
                const SizedBox(height: 8),

                // 🔵 Tombol Masuk
                ElevatedButton(
                  onPressed: loginUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF264ECA), // biru
                    foregroundColor: Colors.white,             // teks putih
                    elevation: 4,
                    shadowColor: Colors.black45,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Masuk",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                const Text(
                  "Lupa Password",
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buttonTab({
    required String text,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? const Color(0xFF264ECA) : Colors.white,
        foregroundColor: selected ? Colors.white : Colors.blue,
        elevation: selected ? 6 : 2,
        shadowColor: Colors.black26,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: selected ? null : const BorderSide(color: Colors.blue),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _inputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            filled: true,
            fillColor: Colors.grey.shade200,
          ),
        ),
      ],
    );
  }
}