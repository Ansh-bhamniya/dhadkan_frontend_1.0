import 'package:dhadkan_front/utils/constants/colors.dart';
import 'package:dhadkan_front/utils/device/device_utility.dart';
import 'package:dhadkan_front/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:dhadkan_front/utils/http/http_client.dart';

class DoctorSignUpScreen extends StatefulWidget {
  const DoctorSignUpScreen({super.key});

  @override
  State<DoctorSignUpScreen> createState() => _DoctorSignUpScreenState();
}

class _DoctorSignUpScreenState extends State<DoctorSignUpScreen> {
  // Controllers for input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController hospitalController = TextEditingController();

  // Function to handle sign-up
  Future<void> handleSignUp(BuildContext context) async {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String hospital = hospitalController.text.trim();

    if (name.isEmpty || phone.isEmpty || password.isEmpty || hospital.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      Map<String, dynamic> response =
          await MyHttpHelper.post('/doctor/signup', {
        'name': name,
        'mobile': phone,
        'password': password,
        'hospital': hospital,
        'email': email,
      });

      // Handle response
      print(response);
      if (response['success'] == "true") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response['message'])));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response['message'] ?? 'Registration failed!')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('An error occurred during registration')));
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MyDeviceUtils.getScreenWidth(context);
    var paddingWidth = screenWidth * 0.05;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Doctor Registration',
          style: MyTextTheme.textTheme.headlineSmall
              ?.copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Sign-Up As a Doctor',
                style: MyTextTheme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              _buildTextFormField(
                label: 'Name',
                controller: nameController,
              ),
              const SizedBox(height: 10),
              _buildTextFormField(
                label: 'Phone',
                controller: phoneController,
              ),
              const SizedBox(height: 20),
              _buildTextFormField(
                label: 'Email',
                controller: emailController,
              ),
              const SizedBox(height: 20),
              _buildTextFormField(
                label: 'Password',
                controller: passwordController,
                isObscured: true,
              ),
              const SizedBox(height: 20),
              _buildTextFormField(
                label: 'Hospital',
                controller: hospitalController,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => handleSignUp(context),
                  // Pass function reference
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 16),
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

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    hospitalController.dispose();
    super.dispose();
  }
}

Widget _buildTextFormField({
  required String label,
  required TextEditingController controller,
  bool isObscured = false,
}) {
  return TextFormField(
    controller: controller,
    obscureText: isObscured,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
