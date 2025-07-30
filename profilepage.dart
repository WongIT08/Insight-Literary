import 'package:flutter/material.dart';
import 'package:flutter_application_1/edit_profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> user;

  ProfilePage({required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Map<String, dynamic> user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue.shade800,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: user['image'] != null && user['image'] != ''
                  ? NetworkImage('http://192.168.56.1:8000/uploads/profile/${user['image']}')
                  : AssetImage('assets/default_avatar.png') as ImageProvider,
            ),
            SizedBox(height: 10),
            Text(
              user['fullname'] ?? '-',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text('@${user['username'] ?? ''}', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 8),
            Text(user['bio'] ?? '-', textAlign: TextAlign.center),
            SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStat('Favorit Book', user['favoriteBookCount'] ?? 0),
                _buildStat('Premium Book', user['premiumBookCount'] ?? 0),
                _buildStat('Penulis Favorit', user['penulisFavoriteCount'] ?? 0),
              ],
            ),
            SizedBox(height: 16),

            ListTile(
              leading: Icon(Icons.cake),
              title: Text('Tanggal Lahir'),
              subtitle: Text(user['birth_date'] ?? '-'),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Lokasi'),
              subtitle: Text(user['location'] ?? '-'),
            ),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text('Bergabung Sejak'),
              subtitle: Text(user['joinedAt'] ?? '-'),
            ),

            SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () async {
                final updatedUser = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      idUser: int.parse(user['id_user'].toString()),
                      fullname: user['fullname'] ?? '',
                      bio: user['bio'] ?? '',
                      birthDate: user['birth_date'],
                      gender: user['gender'],
                      location: user['location'],
                      image: user['image'],
                    ),
                  ),
                );

                // kalau EditProfilePage return user baru → update state
                if (updatedUser != null) {
                  setState(() {
                    user = updatedUser;
                  });
                }
              },
              icon: Icon(Icons.edit),
              label: Text('Edit Profil'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                minimumSize: Size(double.infinity, 48),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _logout,
              icon: Icon(Icons.logout),
              label: Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, int count) {
    return Column(
      children: [
        Text('$count', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
