import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/colors.dart' as colors;
import 'package:flutter_application_1/services/storage_service.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> handleLogin() async {
    if (emailController.text.isEmpty) {
      Get.snackbar("Error", "Enter your email");
      return;
    }

    if (passwordController.text.isEmpty) {
      Get.snackbar("Error", "Enter your password");
      return;
    }

    final users = await StorageService.loadUsers();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    Map<String, dynamic>? matchedUser;

    for (final user in users) {
      if (user['email'] == email && user['password'] == password) {
        matchedUser = user;
        break;
      }
    }

    if (matchedUser == null) {
      Get.snackbar("Login Failed", "Invalid email or password");
      return;
    }

    await StorageService.saveCurrentUser({
      'id': matchedUser['id'],
      'firstname': matchedUser['firstname'],
      'lastname': matchedUser['lastname'],
      'email': matchedUser['email'],
      'phone': matchedUser['phone'],
    });

    Get.snackbar("Success", "Login successful!");
    Get.offAllNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 100),

              Image.asset(
                "assets/jumia_logo.png",
                width: 200,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.shopping_cart,
                      size: 100, color: Colors.orange);
                },
              ),

              const SizedBox(height: 40),

              // EMAIL
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: const Icon(Icons.email),
                ),
              ),

              const SizedBox(height: 20),

              // PASSWORD
              TextField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // LOGIN BUTTON
              GestureDetector(
                onTap: handleLogin,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // SIGN UP LINK
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/signup');
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}