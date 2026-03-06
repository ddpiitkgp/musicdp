import 'package:flutter/material.dart';
import 'package:musicdp/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailPhoneController = TextEditingController();
  bool isAgreed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const SizedBox(height: 80),

              /// Logo
              const Icon(
                Icons.music_note,
                size: 80,
                color: Colors.greenAccent,
              ),

              const SizedBox(height: 20),

              const Text(
                "MusicDP",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Stream your sound",
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 60),

              /// Input
              TextField(
                controller: emailPhoneController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Email or Mobile Number",
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white10,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Checkbox(
                    value: isAgreed,
                    activeColor: Colors.greenAccent,
                    onChanged: (value) {
                      setState(() {
                        isAgreed = value!;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      "I agree to MusicDP Terms & Conditions",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              /// Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: isAgreed ? ()  {
                    String user = emailPhoneController.text.trim();
                    // ADD VALIDATION HERE
                    if (user.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Enter email or phone")),
                      );
                      return;
                    }
                    if (user.isNotEmpty) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                  } : null,
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}