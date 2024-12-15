import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../database/auth.dart';
import 'login_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final picker = ImagePicker();

  String name = '';
  String role = 'customer'; // Default role
  String _base64Image = '';
  bool _isPasswordVisible = false;
  bool isLoading = false;
  bool agreeToTerms = false;

  File? _image;
  DateTime _selectedDate = DateTime.now();
  bool? _isFemale;

  Future<void> uploadImg() async {
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final bytes = await pickedImage.readAsBytes();
      setState(() {
        _image = File(pickedImage.path);
        _base64Image = base64Encode(bytes);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate() || !agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields and agree to the terms'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => isLoading = true);
    final authService = AuthService();
    final result = await authService.signUp(
      context,
      _emailController.text,
      _passwordController.text,
      name,
      role,
      _base64Image,
    );
    setState(() => isLoading = false);

    if (result != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registered Successfully!!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Register Now!!",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/login');
                    },
                    child:Icon(Icons.arrow_back_ios) ,
                  )
                ],
              ),
              const SizedBox(height: 10),
              _buildInputField(
                label: 'Fullname:',
                hint: 'Full Name',
                icon: Icons.person_outline,
                onChanged: (value) => name = value,
              ),

              const SizedBox(height: 10),
              _buildInputField(
                label: 'Email:',
                hint: 'Email',
                icon: Icons.email_outlined,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              _buildPasswordField(),
              const SizedBox(height: 10),
              _buildRoleSelector(),
              const SizedBox(height: 10),
              _buildAgreementCheckbox(),
              const SizedBox(height: 10),
              _buildFileUpload(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required IconData icon,
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            filled: true,
            fillColor: const Color.fromARGB(255, 194, 190, 190),
            enabledBorder: _inputBorder(Colors.purple),
            focusedBorder: _inputBorder(Colors.blue),
          ),
          onChanged: onChanged,
          validator: (value) =>
          value == null || value.isEmpty ? 'This field is required' : null,
        ),
      ],
    );
  }

  OutlineInputBorder _inputBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 2),
      borderRadius: BorderRadius.circular(20),
    );
  }

  Widget _buildPasswordField() {
    return _buildInputField(
      label: 'Password:',
      hint: 'Password',
      icon: Icons.password_outlined,
      controller: _passwordController,
      onChanged: null,
    );
  }


  Widget _buildRoleSelector() {
    return Row(
      children: [
        Radio<String>(
          value: 'customer',
          groupValue: role,
          onChanged: (value) => setState(() => role = value!),
        ),
        const Text('Customer'),
        Radio<String>(
          value: 'admin',
          groupValue: role,
          onChanged: (value) => setState(() => role = value!),
        ),
        const Text('Admin'),
      ],
    );
  }

  Widget _buildAgreementCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: agreeToTerms,
          onChanged: (value) => setState(() => agreeToTerms = value!),
        ),
        const Text('I agree to terms and conditions'),
      ],
    );
  }

  Widget _buildFileUpload() {
    return TextButton.icon(
      onPressed: uploadImg,
      icon: const Icon(Icons.file_upload),
      label: const Text('Upload Avatar'),
    );
  }
}
