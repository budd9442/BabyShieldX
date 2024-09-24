import 'package:flutter/material.dart';


class HospitalSignUpStep1 extends StatelessWidget {
  final TextEditingController hospitalNameController = TextEditingController();
  final TextEditingController slmcController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final List<String> hospitalTypes = ['Public', 'Private'];

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
            const SizedBox(height: 10),
            const Text(
              'Step 1',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: "Hospital name*",
              controller: hospitalNameController,
              hintText: "Enter hospital's Full Name",
            ),
            CustomDropdownField(
              label: "Hospital type*",
              items: hospitalTypes,
              hintText: "Select hospital type",
            ),
            CustomTextField(
              label: "SLMC Registration number*",
              controller: slmcController,
              hintText: "Enter SLMC number",
            ),
            CustomTextField(
              label: "Hospital E-mail*",
              controller: emailController,
              hintText: "Enter hospital E-mail",
              keyboardType: TextInputType.emailAddress,
            ),
            CustomTextField(
              label: "Password*",
              controller: passwordController,
              hintText: "Create strong password",
              obscureText: true,
            ),
            CustomTextField(
              label: "Confirm Password*",
              controller: confirmPasswordController,
              hintText: "Re-write your password",
              obscureText: true,
            ),
            CustomTextField(
              label: "Hospital number",
              controller: phoneController,
              hintText: "Enter hospital phone number",
              keyboardType: TextInputType.phone,
              prefix: Container(
                padding: const EdgeInsets.only(right: 10),
                child: const Text("+94"),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HospitalSignUpStep2()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16), backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                TextButton(
                  onPressed: () {
                    // Log in functionality
                  },
                  child: const Text("Log in"),
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

class CustomDropdownField extends StatelessWidget {
  final String label;
  final List<String> items;
  final String hintText;

  const CustomDropdownField({
    Key? key,
    required this.label,
    required this.items,
    required this.hintText,
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
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
            hint: Text(hintText),
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
class HospitalSignUpStep2 extends StatelessWidget {
  final TextEditingController street1Controller = TextEditingController();
  final TextEditingController street2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController phone1Controller = TextEditingController();
  final TextEditingController phone2Controller = TextEditingController();
  final List<String> districts = ['District 1', 'District 2', 'District 3'];
  final List<String> positions = ['Position 1', 'Position 2', 'Position 3'];

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
            const SizedBox(height: 10),
            const Text(
              'Step 2',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 20),
            CustomDropdownField(
              label: "Select District",
              items: districts,
              hintText: "Select your District",
            ),
            CustomTextField(
              label: "Permanent address",
              controller: street1Controller,
              hintText: "street 1",
            ),
            CustomTextField(
              label: "",
              controller: street2Controller,
              hintText: "street 2",
            ),
            CustomTextField(
              label: "",
              controller: cityController,
              hintText: "city/town",
            ),
            CustomDropdownField(
              label: "Position*",
              items: positions,
              hintText: "Select your position",
            ),
            CustomTextField(
              label: "Phone numbers",
              controller: phone1Controller,
              hintText: "Enter phone number 1",
              keyboardType: TextInputType.phone,
            ),
            CustomTextField(
              label: "",
              controller: phone2Controller,
              hintText: "Enter phone number 2",
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Proceed to the next step or finalize sign-up
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16), backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
