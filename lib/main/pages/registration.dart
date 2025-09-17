import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tapasucon/main/MainDashboard.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  bool isLogin = true;

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final String baseUrl = "https://ormatrix.in/tapasucon2025/"; // <-- change this

  Future<void> register() async {
    var url = Uri.parse("$baseUrl/register.php");
    var response = await http.post(url, body: {
      "mobile": mobileController.text,
      "name": nameController.text,
      "password": passwordController.text,
    });

    var data = jsonDecode(response.body);
    _showMessage(data["message"]);
  }

  Future<void> login() async {
    var url = Uri.parse("$baseUrl/login.php");
    var response = await http.post(url, body: {
      "mobile": mobileController.text,
      "password": passwordController.text,
    });

    var data = jsonDecode(response.body);
    _showMessage(data["message"]);

    if (data["status"] == "success") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MainDashboard(),
        ),
      );
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isLogin ? "Login" : "Register",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: "Mobile Number",
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    if (!isLogin) ...[
                      const SizedBox(height: 10),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () => isLogin ? login() : register(),
                      child: Text(isLogin ? "Login" : "Register"),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: Text(isLogin
                          ? "Don’t have an account? Register"
                          : "Already have an account? Login"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   final String userName;
//   const HomePage({super.key, required this.userName});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Welcome $userName")),
//       body: Center(
//         child: Text(
//           "Hello, $userName 👋",
//           style: const TextStyle(fontSize: 22),
//         ),
//       ),
//     );
//   }
// }
