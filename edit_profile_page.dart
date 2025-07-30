import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  final int idUser;
  final String fullname;
  final String bio;
  final String? birthDate;
  final String? gender;
  final String? location;
  final String? image;

  EditProfilePage({
    required this.idUser,
    required this.fullname,
    required this.bio,
    this.birthDate,
    this.gender,
    this.location,
    this.image,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController fullnameController;
  late TextEditingController bioController;
  late TextEditingController birthDateController;
  late TextEditingController locationController;
  String? selectedGender;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    fullnameController = TextEditingController(text: widget.fullname);
    bioController = TextEditingController(text: widget.bio);
    birthDateController = TextEditingController(text: widget.birthDate ?? '');
    locationController = TextEditingController(text: widget.location ?? '');
    selectedGender = widget.gender; // 'L' atau 'P'
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    var uri = Uri.parse('http://10.0.2.2:8000/api/profile/update'); // ganti sesuai IP backend
    var request = http.MultipartRequest('POST', uri);

    request.fields['id_user'] = widget.idUser.toString();
    request.fields['fullname'] = fullnameController.text.trim();
    request.fields['bio'] = bioController.text.trim();
    request.fields['birth_date'] = birthDateController.text.trim();
    request.fields['location'] = locationController.text.trim();
    request.fields['gender'] = selectedGender ?? '';

    if (_imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('image', _imageFile!.path));
    }

    var response = await request.send();

   if (response.statusCode == 200) {
  final responseData = await http.Response.fromStream(response);
  final json = jsonDecode(responseData.body);
  final updatedUser = json['data'];

  final prefs = await SharedPreferences.getInstance();
  prefs.setString('user', jsonEncode(updatedUser));

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Profil berhasil diperbarui')),
  );

  Navigator.pop(context, updatedUser); // kirim user baru ke ProfilePage
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Gagal update profil')),
  );
}

  }

  @override
  Widget build(BuildContext context) {
    String baseUrl = 'http://10.0.2.2:8000'; // ganti sesuai backend
    String? oldImageUrl = widget.image != null && widget.image != ''
        ? '$baseUrl/uploads/profile/${widget.image}'
        : null;

    return Scaffold(
      appBar: AppBar(title: Text('Edit Profil')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : (oldImageUrl != null
                        ? NetworkImage(oldImageUrl)
                        : AssetImage('assets/default_avatar.png') as ImageProvider),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: fullnameController,
              decoration: InputDecoration(labelText: 'Nama Lengkap'),
            ),
            TextField(
              controller: bioController,
              decoration: InputDecoration(labelText: 'Bio'),
            ),
            TextField(
              controller: birthDateController,
              decoration: InputDecoration(labelText: 'Tanggal Lahir (YYYY-MM-DD)'),
            ),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Lokasi'),
            ),
            DropdownButtonFormField<String>(
              value: selectedGender,
              items: [
                DropdownMenuItem(value: 'L', child: Text('Laki-laki')),
                DropdownMenuItem(value: 'P', child: Text('Perempuan')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
              decoration: InputDecoration(labelText: 'Jenis Kelamin'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProfile,
              child: Text('Simpan'),
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 48)),
            )
          ],
        ),
      ),
    );
  }
}
