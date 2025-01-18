import 'package:flutter/material.dart';
import 'package:my_project/ui/chatbot_screen.dart';
import '../login/loginscreen.dart'; // Pastikan Anda mengimpor LoginScreen

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _visiMisiKey = GlobalKey();
  final GlobalKey _topSectionKey = GlobalKey();
  Color _homeButtonColor = Colors.transparent;
  Color _aboutButtonColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height:50), // Spacer for the fixed header
                // Bagian Atas
                Container(
                  key: _topSectionKey,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/chatty.png',
                          height: 400,
                          width: 400,
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 600,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ChatBotScreen()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 1, 104, 66),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                ),
                                child: const Text(
                                  "Let's Go",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: 600,
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
                        Container(
                          key: _visiMisiKey,
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
                                        backgroundColor: const Color.fromARGB(255, 1, 104, 66),
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
                ),
                Container(
                  color: const Color(0xFF004D40),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 70,
                            backgroundColor: Color.fromARGB(255, 74, 116, 74),
                            backgroundImage:
                                AssetImage('assets/images/perpus.png'),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Sekretariat',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Alamat  : Jl. Brawijaya, Kasihan, Bantul 55183',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              'Email   : Perpustakaan@umy.ac.id',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              'Telp    : 0274.387656 psw 140/141/149/492',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              'Faks    : 0274.387646',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              'NPP     : 3402162D2000002',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildSocialIcon(Icons.facebook, Colors.blue),
                                const SizedBox(width: 8),
                                _buildSocialIcon(Icons.tiktok, Colors.purple),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        flex: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jam Layanan Luring',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '• Senin-Jum\'at       : 08.00 - 21.00 WIB',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '• Sabtu                  : 08.00 - 15.00 WIB',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '• Istirahat              : 11.30 - 12.30 WIB',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '• Istirahat Jum\'at   : 11.00 - 13.00 WIB',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  const SizedBox(height: 10), // Add space from the top
                  Row(
                    children: [
                      MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _homeButtonColor = const Color.fromARGB(255, 255, 193, 7);
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _homeButtonColor = Colors.transparent;
                          });
                        },
                        child: TextButton(
                          onPressed: () {
                            _scrollToTop();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: _homeButtonColor,
                          ),
                          child: const Text(
                            'Home',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                      MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _aboutButtonColor = const Color.fromARGB(255, 255, 193, 7);
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _aboutButtonColor = Colors.transparent;
                          });
                        },
                        child: TextButton(
                          onPressed: () {
                            _scrollToVisiMisi();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: _aboutButtonColor,
                          ),
                          child: const Text(
                            'About',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                      const Spacer(flex: 15),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 1, 104, 66),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _scrollToTop() {
    final context = _topSectionKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context, duration: const Duration(seconds: 1));
    }
  }

  void _scrollToVisiMisi() {
    final context = _visiMisiKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context, duration: const Duration(seconds: 1));
    }
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: color,
      child: Icon(icon, color: Colors.white),
    );
  }
}