import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://perpusdb.test/api"; // Ganti dengan URL API Laravel Anda

  // Mengirimkan pertanyaan ke API menggunakan GET dan menerima jawaban
  static Future<List<dynamic>> ask(String questionText) async {
    // Encode questionText untuk memastikan aman dikirim dalam URL
    final encodedQuestion = Uri.encodeComponent(questionText);

    // Tambahkan pertanyaan ke URL sebagai query parameter
    final url = Uri.parse('$baseUrl/ask?question=$encodedQuestion');

    // Kirim permintaan GET ke API
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Jika berhasil, kembalikan data JSON yang berisi jawaban
      return json.decode(response.body);
    } else {
      // Jika gagal, lempar exception
      throw Exception('Failed to get answer');
    }
  }

  Future<void> storeQuestionAndAnswer(String question, List<String> answers) async {
    final url = Uri.parse('$baseUrl/storedata');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'question_text': question,
        'answers': answers,
      }),
    );

    if (response.statusCode == 201) {
      print("Data berhasil disimpan: ${response.body}");
    } else {
      print("Gagal menyimpan data: ${response.body}");
    }
  }

  
}
