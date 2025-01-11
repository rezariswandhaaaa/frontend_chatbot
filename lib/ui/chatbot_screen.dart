import 'package:flutter/material.dart';
import 'package:my_project/services/api_service.dart';
import 'package:my_project/ui/landingpage.dart'; // Import ApiService

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({Key? key}) : super(key: key);

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, String>> _messages = [];
  bool _isLoading = false;
  String _selectedCategory = 'Informasi Umum'; // Default category

  final Map<String, List<String>> _questionsByCategory = {
    'Informasi Umum': [
      'Apa itu Repository?',
      'Apa itu OPAC (Online Public Access Catalog)?',
      'Berapa jumlah buku yang dapat dipinjam?',
      'Berapa lama masa pinjam buku di perpustakaan UMY?',
      'Berapa denda yang diberikan jika terlambat mengembalikan buku?',
      'Bagaimana prosedur untuk mendapatkan surat bebas pustaka?',
      'Bagaimana cara meminjam buku secara online?',
    ],
    'Layanan': [
      'Jam layanan Perpustakaan UMY',
      'Ruang sidang Perpustakaan',
      'Ruang komputer',
      'Cek Turnitin',
    ],
  };

  Future<void> _sendMessage() async {
    final query = _controller.text;
    if (query.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': query});
      _isLoading = true;
    });

    try {
      final response = await ApiService.ask(query);
      setState(() {
        _isLoading = false;

        // Jika response kosong, tampilkan pesan arahkan ke WhatsApp
        if (response.isEmpty) {
          _messages.add(
              {'sender': 'bot', 'text': 'Terjadi kesalahan. Coba lagi nanti.'});
        } else {
          // Jika ada jawaban dari API, tampilkan jawaban tersebut
          String answersText =
              response.map((e) => e['answer_text']).join('\n\n');
          _messages.add({'sender': 'bot', 'text': answersText});
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        // Tampilkan pesan jika terjadi kesalahan pada koneksi API
        _messages.add({
          'sender': 'bot',
          'text':
              'Jawaban tidak ditemukan. Silakan hubungi admin melalui WhatsApp.'
        });
        _messages.add({
          'sender': 'bot',
          'text':
              'Klik di sini(https://wa.me/6281234567890) untuk menghubungi admin.'
        });
      });
    }

    _controller.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[700],
        child: Center(
          child: Container(
            width: 1200,
            height: 600,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 74, 116, 74),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Tombol Kembali (panah kiri)
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LandingPage(),
                              ));
                        },
                      ),
                      const SizedBox(width: 8),
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/chatty.png'),
                        radius: 30,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Chat with us anytime, anywhere!',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                // Chat area
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount:
                        _messages.length + 2, // +3 for welcome & categories
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return _buildWelcomeMessage();
                      } else if (index == 1) {
                        return _buildQuestions();
                      } else {
                        final message = _messages[index - 2];
                        final isUser = message['sender'] == 'user';
                        return _buildChatBubble(message['text']!, isUser);
                      }
                    },
                  ),
                ),

                // Input area
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Ketik pertanyaan...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      CircleAvatar(
                        backgroundColor: Colors.teal,
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.white),
                          onPressed: _sendMessage,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeMessage() {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.asset(
          'assets/images/chatty.png',
          width: 40,
          height: 40,
        ),
      ),
      title: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 144, 36, 36),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Selamat datang, ada yang bisa dibantu?',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.asset(
              'assets/images/chatty.png',
              width: 40,
              height: 40,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 144, 36, 36),
                borderRadius: BorderRadius.circular(8),
              ),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: _questionsByCategory.keys.map((category) {
                        final isSelected = _selectedCategory == category;
                        return Padding(
                          padding: const EdgeInsets.only(left: 8, top: 8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.blue
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _questionsByCategory[_selectedCategory]!
                            .map((question) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      _controller.text = question;
                                      _sendMessage();
                                    },
                                    child: Text(
                                      question,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String text, bool isUser) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser)
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset(
                'assets/images/chatty.png',
                width: 40,
                height: 40,
              ),
            ),
          if (!isUser) const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: isUser
                    ? const Color.fromARGB(255, 144, 36, 36)
                    : const Color.fromARGB(255, 144, 36, 36),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: isUser ? const Radius.circular(12) : Radius.zero,
                  bottomRight: isUser ? Radius.zero : const Radius.circular(12),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isUser ? Colors.white : Colors.white,
                  fontSize: 16.0,
                  height: 1.5,
                ),
              ),
            ),
          ),
          if (isUser) const SizedBox(width: 8),
          if (isUser)
            const CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.person, color: Colors.white),
            ),
        ],
      ),
    );
  }
}
