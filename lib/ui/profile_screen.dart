import 'package:flutter/material.dart';
import 'package:my_project/ui/landingpage.dart';
import 'admin_screen.dart'; // Import AdminScreen for consistent sidebar

class ProfileSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: const Color.fromARGB(255, 74, 116, 74),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile.jpg'), // Ganti dengan path gambar profil
            radius: 16,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(child: Text('Hai, Admin!')),
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar (same as AdminScreen)
          Container(
            width: 250,
            color: Colors.grey[200],
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Chatty Muda, AI',
                    style: TextStyle(
                      color: Color.fromARGB(255, 144, 36, 36),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.info,
                  label: 'Data Informasi',
                  onTap: () {
                    // Navigasi ke Data Informasi
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminScreen(),
                      ),
                    );
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.person,
                  label: 'Pengaturan Profil',
                  isActive: true,
                  onTap: () {
                    // Navigasi ke Pengaturan Profil
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.white),
                  title: const Text('Logout',
                      style: TextStyle(color: Colors.white)),
                  
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LandingPage())); // Navigasi Logout
                  },
                ),
              ],
            ),
          ),
          // Main Content (Profile settings content)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pengaturan Profil',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Content for profile settings goes here
                  const Text('Nama: Admin'),
                  const SizedBox(height: 8),
                  const Text('Email: admin@chattymuda.com'),
                  // Add more profile settings fields here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    bool isActive = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      onHover: (isHovered) {
        // Gunakan logika untuk efek hover
      },
      child: ListTile(
        leading: Icon(icon, color: isActive ? Colors.red : Colors.black),
        title: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.red : Colors.black,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        tileColor: isActive ? Colors.red.shade100 : null,
      ),
    );
  }
}
