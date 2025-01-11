import 'package:flutter/material.dart';
import 'package:my_project/services/auth_service.dart'; // Pastikan import AuthService
import 'package:email_validator/email_validator.dart'; 

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 74, 116, 74),
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your email to reset your password:',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14.0,
                  ),
                ),
              ),
            if (_successMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  _successMessage!,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 14.0,
                  ),
                ),
              ),
            /*ElevatedButton(
              onPressed: _isLoading ? null : ,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 74, 116, 74),
                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
            ),*/
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menangani permintaan reset password
  /*void _resetPassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    final email = _emailController.text;

    // Validasi email
    if (email.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Email cannot be empty!';
      });
      return;
    }

    // Validasi format email
    if (!EmailValidator.validate(email)) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Invalid email format!';
      });
      return;
    }

    // Panggil AuthService untuk mengirim permintaan reset password
    final authService = AuthService();
    final response = await authService.resetPassword(email);

    setState(() {
      _isLoading = false;
    });

    if (response['error'] != null && response['error'] == true) {
      // Jika gagal, tampilkan pesan error
      setState(() {
        _errorMessage = response['message'];
      });
    } else {
      // Jika berhasil, tampilkan pesan sukses
      setState(() {
        _successMessage = 'Password reset link has been sent to your email.';
      });
    }
  } */
}
