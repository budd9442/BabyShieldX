import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ParentRegisterScreen extends StatelessWidget {
  final TextEditingController parentNameController = TextEditingController();
  final TextEditingController nicController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Create Your Account',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            CustomTextField(
              label: "Parent’s name",
              controller: parentNameController,
              hintText: "Enter your name",
            ),
            CustomTextField(
              label: "NIC number",
              controller: nicController,
              hintText: "Enter your NIC number",
            ),
            CustomTextField(
              label: "E-mail",
              controller: emailController,
              hintText: "Enter your E-mail",
              keyboardType: TextInputType.emailAddress,
            ),
            CustomTextField(
              label: "Password",
              controller: passwordController,
              hintText: "Enter your password",
              obscureText: true,
            ),
            CustomTextField(
              label: "Confirm Password",
              controller: confirmPasswordController,
              hintText: "Re-write your password",
              obscureText: true,
            ),
            CustomTextField(
              label: "Phone number",
              controller: phoneController,
              hintText: "Enter your phone number",
              keyboardType: TextInputType.phone,
              prefix: Container(
                padding: const EdgeInsets.only(right: 10),
                child: const Text("+94"),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                if (passwordController.text == confirmPasswordController.text) {
                  try {
                    // Register user using Supabase auth
                    final response = await Supabase.instance.client.auth.signUp(
                      email: emailController.text,
                      password: passwordController.text,
                      data: {
                        'parent_name': parentNameController.text,
                        'nic': nicController.text,
                        'phone': phoneController.text,
                      },
                    );

                    if (response.user != null) {
                      // User registered successfully
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Registration Successful!"),
                      ));
                      Navigator.pushNamed(context, '/login');
                    } else if (response.user != null) {
                      // Show error if registration fails
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Error"),
                      ));
                    }
                  } catch (e) {
                    // Handle any other errors
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Error: $e'),


                    ));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Passwords do not match')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Register',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?",style: TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text("Log in",style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefix;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.prefix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              prefixIcon: prefix != null ? Padding(padding: const EdgeInsets.all(8), child: prefix) : null,
            ),
          ),
        ],
      ),
    );
  }
}
