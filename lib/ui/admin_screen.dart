// admin_screen.dart
import 'package:flutter/material.dart';
import 'package:my_project/ui/landingpage.dart';
import 'package:my_project/ui/profile_screen.dart';
// Import ProfileSettingsScreen from another file if needed.

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 74, 116, 74),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage(
                'assets/profile.jpg'), // Ganti dengan path gambar profil
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
          // Sidebar
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
                  isActive: true,
                  onTap: () {
                    // Navigasi ke Data Informasi
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.person,
                  label: 'Pengaturan Profil',
                  onTap: () {
                    // Navigasi ke Pengaturan Profil
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileSettingsScreen(),
                      ),
                    );
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
          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Data Informasi',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Aksi tambah data
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Tambah Data',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 74, 116, 74),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Cari Data',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    
                    child: Card(
                      elevation: 4,
                      child: _buildDataTable(),
                    ),
                  ),
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

  Widget _buildDataTable() {
    return SingleChildScrollView(
      child: DataTable(
        columns: const [
          DataColumn(label: Text('#')),
          DataColumn(label: Text('Tanggal')),
          DataColumn(label: Text('Tanggapan')),
          DataColumn(label: Text('Keywords')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Action')),
        ],
        rows: [
          _buildDataRow(
            id: '1',
            date: '2024-12-12',
            response: 'Buku dengan judul "Planet" ada...',
            keywords: 'Informasi Umum',
            status: 'Terjawab',
            statusColor: Colors.green,
          ),
          _buildDataRow(
            id: '2',
            date: '2024-12-20',
            response: 'Repository adalah layanan per...',
            keywords: 'Informasi Umum',
            status: 'Belum Terjawab',
            statusColor: Colors.red,
          ),
          _buildDataRow(
            id: '3',
            date: '2024-12-22',
            response: 'Untuk mencari jurnal, silakan...',
            keywords: 'Layanan',
            status: 'Terjawab',
            statusColor: Colors.green,
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow({
    required String id,
    required String date,
    required String response,
    required String keywords,
    required String status,
    required Color statusColor,
  }) {
    return DataRow(
      cells: [
        DataCell(Text(id)),
        DataCell(Text(date)),
        DataCell(Text(response)),
        DataCell(Text(keywords)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
              style: TextStyle(color: statusColor),
            ),
          ),
        ),
        DataCell(
          Row(
            children: const [
              Icon(Icons.edit, color: Colors.black),
              SizedBox(width: 8),
              Icon(Icons.delete, color: Colors.black),
            ],
          ),
        ),
      ],
    );
  }
}
