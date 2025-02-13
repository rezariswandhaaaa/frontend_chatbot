import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "http://perpusdb.test/api"; // Ganti dengan URL API Laravel Anda

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

  Future<List<dynamic>> getQuestionsWithAnswers() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/getdata"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data']; // Sesuai dengan respons JSON API Anda
      } else {
        throw Exception('Failed to load questions');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> storeQuestionAndAnswer({
    required String questionText,
    required String answer,
  }) async {
    final url = Uri.parse('$baseUrl/storedata'); // Endpoint Laravel API

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'question_text': questionText,
          'answer': answer,
        }),
      );

      if (response.statusCode == 201) {
        // Parsing respons jika berhasil
        return json.decode(response.body);
      } else {
        // Parsing respons jika ada error
        final responseBody = json.decode(response.body);
        throw Exception(responseBody['message'] ?? 'Gagal menyimpan data');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<void> updateQuestion(int id, Map<String, dynamic> data) async {
    try {
      print('Mengirim data: $data');
      final response = await http.put(
        Uri.parse('$baseUrl/edit/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      print('Respons dari API: ${response.body}');
      if (response.statusCode == 200) {
        print('Pertanyaan berhasil diperbarui');
      } else {
        throw Exception('Failed to update question: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Something went wrong while updating the question');
    }
  }

  Future<void> deleteQuestion(int id) async {
    final url = Uri.parse('$baseUrl/questions/$id'); // Endpoint delete API

    try {
      final response = await http.delete(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Jika berhasil dihapus
        print('Pertanyaan berhasil dihapus');
      } else {
        // Parsing pesan error dari respons
        final responseBody = json.decode(response.body);
        throw Exception(responseBody['message'] ?? 'Gagal menghapus data');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<bool> sendResetPasswordEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/forgot"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      if (response.statusCode == 200) {
        return true; // Email berhasil dikirim
      } else {
        print("Error: ${response.body}");
        return false; // Gagal mengirim email
      }
    } catch (e) {
      print("Exception: $e");
      return false;
    }
  }


  Future<void> uploadExcel(Uint8List bytes) async {
    try {
      // Buat request URL
      final Uri url = Uri.parse('$baseUrl/imports');

      // Siapkan request multipart
      var request = http.MultipartRequest('POST', url)
        ..headers.addAll({
          'Accept': 'application/json', // Memastikan respons API berupa JSON
          'Content-Type': 'multipart/form-data'
        })
        ..files.add(http.MultipartFile.fromBytes(
          'file', // Nama field yang sesuai di server
          bytes,
          filename: 'uploaded_file.xlsx', // Nama file yang diunggah
        ));

      // Kirimkan request
      var streamedResponse = await request.send();

      // Parsing respons dari server
      var response = await http.Response.fromStream(streamedResponse);

      // Cek status code
      if (response.statusCode == 200) {
        print('Upload berhasil: ${response.body}');
      } else {
        print('Upload gagal: ${response.statusCode}');
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

}
