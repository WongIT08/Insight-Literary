import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth_service.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final usernameController = TextEditingController(); // ganti dari emailController
    final passwordController = TextEditingController();
    final confirmController = TextEditingController();

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
                  style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
                ),

                const SizedBox(height: 24),

                // 🔵 Tab Masuk & Daftar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buttonTab(context, "Masuk", false, () {
                      Navigator.pop(context);
                    }),
                    const SizedBox(width: 50),
                    _buttonTab(context, "Daftar", true, () {}),
                  ],
                ),
                const SizedBox(height: 28),
                
                // 🔵 Input fields
                _inputField("Nama Lengkap", "Nama Lengkap Anda", nameController),
                const SizedBox(height: 16),
                _inputField("Username", "Masukkan username Anda", usernameController),
                const SizedBox(height: 16),
                _inputField("Password", "Minimal 8 Karakter", passwordController, obscure: true),
                const SizedBox(height: 16),
                _inputField("Konfirmasi Password", "Ulangi Password Anda", confirmController, obscure: true),
                const SizedBox(height: 20),

                // 🔵 Tombol Daftar
                ElevatedButton(
                  onPressed: () async {
                    final fullname = nameController.text.trim();
                    final username = usernameController.text.trim();
                    final password = passwordController.text.trim();
                    final confirm = confirmController.text.trim();

                    if (fullname.isEmpty || username.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Semua field wajib diisi')),
                      );
                      return;
                    }

                    if (password != confirm) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Konfirmasi password tidak cocok')),
                      );
                      return;
                    }

                    // Panggil API
                    final result = await AuthService().register(
                      fullname: fullname,
                      username: username,
                      password: password,
                    );

                    if (result['success']) {
                      // Sukses, kembali ke login page
                      if (!context.mounted) return;
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Registrasi berhasil! Silakan login')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(result['message'] ?? 'Gagal daftar')),
                      );
                    }
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF264ECA),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: Colors.black45,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Daftar",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField(String label, String hint, TextEditingController controller, {bool obscure = false}) {
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            filled: true,
            fillColor: Colors.grey.shade200,
          ),
        ),
      ],
    );
  }

  Widget _buttonTab(BuildContext context, String text, bool selected, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: selected ? const Color(0xFF264ECA) : Colors.white,
        foregroundColor: selected ? Colors.white : Colors.blue,
        side: selected ? null : const BorderSide(color: Colors.blue),
        elevation: selected ? 4 : 2,
        shadowColor: Colors.black26,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }
}
