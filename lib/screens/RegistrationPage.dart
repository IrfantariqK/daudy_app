
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _registerUser(BuildContext context) async {
    final String apiUrl = 'your_node_api_registration_endpoint'; // Replace with your actual API endpoint

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        // Handle successful registration response, e.g., display success message
        print('Registration successful: ${responseData['message']}');
      } else {
        // Handle unsuccessful registration response
        print('Registration failed: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      // Handle connection errors or other exceptions
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                _buildInputField(Icons.person, 'Name', _nameController),
                const SizedBox(height: 20),
                _buildInputField(Icons.email, 'Email', _emailController),
                const SizedBox(height: 20),
                _buildPasswordField(_passwordController),
                const SizedBox(height: 20),
                _buildRegisterButton(context),
                const SizedBox(height: 20),
                _buildHaveAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      IconData icon, String hintText, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildPasswordField(TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock, color: Colors.white),
        hintText: 'Password',
        hintStyle: const TextStyle(color: Colors.white),
        suffixIcon: GestureDetector(
          onTap: _togglePasswordVisibility,
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
        ),
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _registerUser(context);
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
        child: Text(
          'Register',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildHaveAccountText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account? ",
          style: TextStyle(color: Colors.white),
        ),
        GestureDetector(
          onTap: () {
            // Navigate to the login page
            Navigator.pop(context);
          },
          child: const Text(
            'Login',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }
}
