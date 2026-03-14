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

  final Map<String, String> acknowledgement = {
    "title": "Acknowledgement",
    "text": "I would like to thank OpenAI and ChatGPT for their helpful guidance and support during the development of MusicDP. The assistance provided greatly helped in solving technical challenges and improving the application. I also appreciate the availability of open-source tools and documentation that supported the development process. Their collective contribution made this project possible."
  };
  @override
  Widget build(BuildContext context) {
    // Get keyboard height for padding
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true, // important
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 0,
                bottom: keyboardHeight + 20, // add extra padding for keyboard
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
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
                          onPressed: isAgreed
                              ? () {
                            String user =
                            emailPhoneController.text.trim();
                            // ADD VALIDATION HERE
                            if (user.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                    Text("Enter email or phone")),
                              );
                              return;
                            }
                            if (user.isNotEmpty) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const HomeScreen(),
                                ),
                              );
                            }
                          }
                              : null,
                          child: const Text(
                            "Continue",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Acknowledgement",
                              style: TextStyle(
                                color: Colors.lightGreenAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "I would like to thank OpenAI and ChatGPT for their helpful guidance and support during the development of MusicDP. The assistance provided greatly helped in solving technical challenges and improving the application. I also appreciate the availability of open-source tools and documentation that supported the development process. Their collective contribution made this project possible.",
                              style: TextStyle(
                                //textAlign: TextAlign.justify,
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(), // pushes content up if screen is tall
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}