import 'package:flutter/material.dart';
import 'package:my_project/services/api_service.dart';
import 'admin_screen.dart'; // Pastikan Anda mengganti dengan path yang sesuai

class AddFormScreen extends StatefulWidget {
  @override
  _AddFormScreenState createState() => _AddFormScreenState();
}

class _AddFormScreenState extends State<AddFormScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submitData() async {
    final String questionText = _questionController.text.trim();
    final String answerText = _answerController.text.trim();

    if (questionText.isEmpty || answerText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua field harus diisi")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _apiService.storeQuestionAndAnswer(
        questionText: questionText,
        answer: answerText,
      );

      // Menampilkan pesan sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );

      // Reset form dan kembali ke AdminScreen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AdminScreen()),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Tambah Pertanyaan",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 74, 116, 74),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tambahkan Pertanyaan Baru",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 74, 116, 74),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Isi form berikut untuk menambahkan pertanyaan dan jawaban.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _questionController,
                decoration: const InputDecoration(
                  labelText: "Pertanyaan",
                  hintText: "Masukkan pertanyaan",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.question_mark),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _answerController,
                decoration: const InputDecoration(
                  labelText: "Jawaban",
                  hintText: "Masukkan jawaban",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.question_answer),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 32),
              Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _submitData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 74, 116, 74),
                          minimumSize: const Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Simpan",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
