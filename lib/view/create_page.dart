import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/models/guard/societies.dart' as loll;
import 'package:society_app/res/component/round_button.dart';
import 'package:society_app/view_model/auth_view_model.dart';
import 'package:society_app/view_model/guard/features.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureText = true;
  String? _selectedName;
  String? _selectedSocietyName;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _nameController = TextEditingController();

  late List<loll.Data> societies;
  bool isLoading = true;

  final List<String> _nameOptions = [
    'Super Admin',
    'society_member',
    'society_admin',
    'vendor',
    'business_partner',
    'security_guard',
  ];

  @override
  void initState() {
    fetchSocieties();
    super.initState();

    // Add a listener to scroll when a text field gains focus
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> fetchSocieties() async {
    try {
      final viewModel = context.read<GuardFeatures>();
      await viewModel.getSocieitiesApi();
      final fetchedData = viewModel.getSoci?.data ?? [];

      setState(() {
        societies = fetchedData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error fetching societies: $e");
    }
  }

  String? _selectedSocietyTitle;
  int? _selectedSocietyId;

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Please Enter',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '\nYour Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Name',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Email',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Register as',
                style: TextStyle(fontSize: 16),
              ),
              DropdownButtonFormField<String>(
                value: _selectedName,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: _nameOptions.map((String name) {
                  return DropdownMenuItem<String>(
                    value: name,
                    child: Text(name),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedName = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Password',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Confirm Password',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _confirmPasswordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Society Name',
                style: TextStyle(fontSize: 16),
              ),
              DropdownButtonFormField<String>(
                value: _selectedSocietyTitle,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.home),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: societies.map((society) {
                  return DropdownMenuItem<String>(
                    value: society.title,
                    child: Text(society.title ?? "Unknown Society"),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSocietyTitle = newValue;

                    // Find the ID of the selected society
                    final selectedSociety = societies.firstWhere(
                      (society) => society.title == newValue,
                      orElse: () => loll.Data(id: null, title: null),
                    );
                    _selectedSocietyId = selectedSociety.id;

                    print("Selected Society Title: $_selectedSocietyTitle");
                    print("Selected Society ID: $_selectedSocietyId");
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Phone Number',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _phoneNumberController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (isLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
              const SizedBox(height: 20),
              Center(
                child: RoundButton(
                  title: 'Register',
                  loading: authViewModel.loading,
                  onPressed: () {
                    // Validate fields before submitting
                    if (_nameController.text.isEmpty ||
                        _emailController.text.isEmpty ||
                        _passwordController.text.isEmpty ||
                        _confirmPasswordController.text.isEmpty ||
                        _selectedName == null ||
                        _phoneNumberController.text.isEmpty ||
                        _selectedSocietyId == null) {
                      // Show error if any field is empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill all fields!')),
                      );
                    } else if (_phoneNumberController.text.isNotEmpty &&
                        !RegExp(r'^[0-9]+$')
                            .hasMatch(_phoneNumberController.text)) {
                      // Validate phone number (should contain only numbers)
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('Phone number must contain only numbers')),
                      );
                    } else if (_passwordController.text !=
                        _confirmPasswordController.text) {
                      // Password and confirm password should match
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Passwords do not match!')),
                      );
                    } else {
                      Map<String, dynamic> data = {
                        "name": _nameController.text,
                        "email": _emailController.text,
                        "password": _passwordController.text,
                        "c_password": _confirmPasswordController.text,
                        "role": _selectedName,
                        "phone_number": _phoneNumberController.text,
                        "society_id": _selectedSocietyId,
                      };
                      print(data);
                      authViewModel.registerUser(data, context);
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: InkWell(
                  onTap: () {
                    GoRouter.of(context).go('/login');
                  },
                  child: Text(
                    'Already have an account? Log In',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
