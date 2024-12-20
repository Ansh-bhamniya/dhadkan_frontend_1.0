import 'package:dhadkan_front/utils/constants/colors.dart';
import 'package:dhadkan_front/utils/device/device_utility.dart';
import 'package:dhadkan_front/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';

import '../../utils/http/http_client.dart';

class PatientSignUpScreen extends StatefulWidget {
  const PatientSignUpScreen({super.key});

  @override
  _PatientSignUpScreenState createState() => _PatientSignUpScreenState();
}

class _PatientSignUpScreenState extends State<PatientSignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController doctorNumberController = TextEditingController();

  Future<void> handleSignUp(BuildContext context) async {
    final String name = nameController.text.trim();
    final String address = addressController.text.trim();
    final String gender = genderController.text.trim();
    final String age = ageController.text.trim();
    final String email = emailController.text.trim();
    final String phone = phoneController.text.trim();
    final String password = passwordController.text.trim();
    final String doctorName = doctorNameController.text.trim();
    final String doctorNumber = doctorNumberController.text.trim();

    if (name.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        age.isEmpty ||
        doctorName.isEmpty ||
        doctorNumber.isEmpty ||
        gender.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill in all fields')));
      return;
    }

    try {
      Map<String, dynamic> response =
          await MyHttpHelper.post('/patient/signup', {
        'name': name,
        'mobile': phone,
        'password': password,
        'email': email,
        'age': age,
        'gender': gender,
        'doctor_mobile': doctorNumber
      });
      print(response);
      if (response['success'] == true) {
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
          'Patient Registration',
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

              // Personal Information Section
              Text(
                'Personal Information',
                style: MyTextTheme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              _buildTextFormField(label: 'Name', controller: nameController),
              const SizedBox(height: 20),
              _buildTextFormField(
                  label: 'Address', controller: addressController),
              const SizedBox(height: 20),
              _buildTextFormField(
                  label: 'Gender', controller: genderController),
              const SizedBox(height: 20),
              _buildTextFormField(label: 'Age', controller: ageController),

              const SizedBox(height: 30),

              // Sign-Up Information Section
              Text(
                'Sign-Up Information',
                style: MyTextTheme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              _buildTextFormField(label: 'Email', controller: emailController),
              const SizedBox(height: 20),
              _buildTextFormField(
                  label: 'Phone Number', controller: phoneController),
              const SizedBox(height: 20),
              _buildTextFormField(
                  label: 'Password',
                  controller: passwordController,
                  isObscured: true),

              const SizedBox(height: 30),

              // Doctor Details Section
              Text(
                'Doctor Details',
                style: MyTextTheme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              _buildTextFormField(
                  label: 'Doctor Name', controller: doctorNameController),
              const SizedBox(height: 20),
              _buildTextFormField(
                  label: 'Doctor Number', controller: doctorNumberController),

              const SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => handleSignUp(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
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

  @override
  void dispose() {
    // Dispose of all controllers to free memory
    nameController.dispose();
    addressController.dispose();
    genderController.dispose();
    ageController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    doctorNameController.dispose();
    doctorNumberController.dispose();
    super.dispose();
  }
}
