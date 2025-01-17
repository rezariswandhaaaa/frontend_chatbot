import 'package:flutter/material.dart';
import 'package:my_project/Authorized/admin_screen.dart';
import 'package:my_project/ui/landingpage.dart';

class PanduanScreen extends StatefulWidget {
  @override
  _PanduanScreenState createState() => _PanduanScreenState();
}

class _PanduanScreenState extends State<PanduanScreen> {
  bool isHoveringDataInformasi = false;
  bool isHoveringLogout = false;
  bool isHoveringPanduan = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            color: Colors.grey[300],
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Text(
                      'Chatty Muda',
                      style: TextStyle(
                        color: Color.fromARGB(255, 144, 36, 36),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: ListView(
                    children: [
                      MouseRegion(
                        onEnter: (event) =>
                            setState(() => isHoveringDataInformasi = true),
                        onExit: (event) =>
                            setState(() => isHoveringDataInformasi = false),
                        child: ListTile(
                          leading: Icon(Icons.info,
                              color: isHoveringDataInformasi
                                  ? Colors.red
                                  : Colors.black),
                          title: Text(
                            'Data Informasi',
                            style: TextStyle(
                              color: isHoveringDataInformasi
                                  ? Color.fromARGB(255, 255, 0, 0)
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminScreen()));
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      MouseRegion(
                        onEnter: (event) =>
                            setState(() => isHoveringPanduan = true),
                        onExit: (event) =>
                            setState(() => isHoveringPanduan = false),
                        child: ListTile(
                          leading: Icon(Icons.menu_book_outlined,
                              color: isHoveringPanduan
                                  ? Colors.red
                                  : Colors.red[400]),
                          title: Text(
                            'Panduan Form Excel',
                            style: TextStyle(
                              color: isHoveringPanduan
                                  ? Color.fromARGB(255, 255, 0, 0)
                                  : Colors.red[400],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(height: 10),
                      MouseRegion(
                        onEnter: (event) =>
                            setState(() => isHoveringLogout = true),
                        onExit: (event) =>
                            setState(() => isHoveringLogout = false),
                        child: ListTile(
                          leading: Icon(Icons.logout,
                              color:
                                  isHoveringLogout ? Colors.red : Colors.black),
                          title: Text(
                            'Logout',
                            style: TextStyle(
                              color:
                                  isHoveringLogout ? Colors.red : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LandingPage()),
                              (Route<dynamic> route) =>
                                  false, // Menghapus semua rute sebelumnya
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Konten Utama
          Expanded(
            child: Column(
              children: [
                // AppBar
                Container(
                  color: const Color.fromARGB(255, 74, 116, 74),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Panduan Form Excel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Text(
                            'Hai, Admin!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Konten
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Langkah-Langkah Mengunggah File Excel',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '1. Pastikan file memiliki Type .xlsx. atau Excel Workbook',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          Image.asset(
                            'assets/images/workbook.png',
                            height: 200,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '2. Gunakan header berikut di file Excel Anda:\n'
                            '   - question_text: Kolom untuk pertanyaan.\n'
                            '   - answer_text: Kolom untuk jawaban.\n',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '3. Pastikan semua data diisi di bawah header tersebut.',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Contoh Format File Excel:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Image.asset(
                            'assets/images/table.png',
                            height: 200,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            '4. Ke Halaman Data Informasi lalu unggah file Excel yang sudah dibuat dengan menekan tombol Import Excel.',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 10),
                          Image.asset(
                            'assets/images/import.png',
                            height: 200,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
