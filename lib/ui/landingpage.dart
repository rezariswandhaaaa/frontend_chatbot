import 'package:flutter/material.dart';
import 'package:my_project/ui/chatbot_screen.dart';
import '../login/loginscreen.dart'; // Pastikan Anda mengimpor LoginScreen

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Bagian Atas
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      // Spacer untuk mendorong 'Home' ke kanan
                      const Spacer(flex: 1),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Home',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),

                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'About',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      // Spacer untuk memberikan jarak tambahan
                      const Spacer(flex: 5),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 74, 116, 74),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                  // Konten Utama
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Perpustakaan Digital Assistant',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Selamat datang di Asisten Perpustakaan Digital kami. Kami hadir untuk membantu Anda menemukan informasi, menjawab pertanyaan, dan memandu Anda dalam menggunakan layanan perpustakaan dengan lebih mudah.',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ChatBotScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 1, 104, 66),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                              ),
                              child: const Text(
                                "Let's Go",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          'assets/images/chatty.png',
                          height: 250,
                          width: 250,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Bagian Tentang Perpustakaan
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Tentang Perpustakaan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Visi
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 144, 36, 36),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'VISI PERPUSTAKAAN UMY\n\nMenjadi Perpustakaan Perguruan Tinggi yang Unggul dalam Layanan Informasi Kemuhammadiyahan, AI Islam, dan Ilmu Pengetahuan Berbasis Teknologi Informasi Komunikasi melalui Kerjasama pada Tahun 2032.',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Misi
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 144, 36, 36),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'MISI PERPUSTAKAAN UMY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...List.generate(5, (index) {
                          final List<String> misi = [
                            'Menyediakan, mengolah, menyimpan, melestarikan, dan memberdayakan sumber informasi, karya akademik, dan karya ilmiah sivitas akademika dan peminat lain.',
                            'Menyediakan media, fasilitas, dan sarana prasarana sharing knowledge bagi sivitas akademika dan peminat lain.',
                            'Mengumpulkan, mendokumentasikan, melestarikan, dan mensosialisasikan karya-karya Kemuhammadiyahan.',
                            'Melakukan pembinaan perpustakaan PTMA se Indonesia dan perpustakan Amal Usaha Muhammadiyah/AUM DIY.',
                            'Menunjang kegiatan pendidikan, penelitian, pengabdian pada masyarakat, dan kegiatan Al Islam dan Kemuhammadiyahan/AIK.'
                          ];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor:
                                      const Color.fromARGB(255, 1, 104, 66),
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    misi[index],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Footer
            Container(
              color: const Color.fromARGB(255, 74, 116, 74),
              padding: const EdgeInsets.all(16),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Sekretariat
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: Color.fromARGB(255, 74, 116, 74),
                            backgroundImage:
                                AssetImage('assets/images/perpus.png'),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sekretariat',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Alamat  : Jl. Brawijaya, Kasihan, Bantul 55183',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Email   : Perpustakaan@umy.ac.id',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Telp    : 0274-387656 psw 140/141/149/492',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Faks    : 0274-387646',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'NPP     : 3402162D2000002',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sosial Media',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.facebook, color: Colors.white),
                              SizedBox(width: 10),
                              Icon(Icons.tiktok, color: Colors.white),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
