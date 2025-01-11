import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // URL API login Laravel
  final String _baseUrl = 'http://perpusdb.test/api/login';

  // Fungsi untuk login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    // Jika status code sukses
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData; // Kembalikan token dan pesan dari server
    } else {
      // Jika login gagal
      return {
        'message': 'Salah, Silahkan Coba Lagi',
        'error': true,
      };
    }
  }
  
}
