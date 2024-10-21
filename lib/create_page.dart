import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:society_app/constant/pallete.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscureText = true;
  String? _selectedName; // Holds the selected name value
  final List<String> _nameOptions = [
    'Super Admin',
    'Society Admin',
    'Residential User',
    'Vendors',
    'Business Partners',
    'Security Gatekeeper',
  ]; // Example roles

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.mainDashColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          // Text outside the DraggableScrollableSheet
          Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 0, left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
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
              ],
            ),
          ),
          Expanded(
            child: DraggableScrollableSheet(
              initialChildSize: 0.95, // Initial height of the sheet
              minChildSize: 0.9, // Minimum height when collapsed
              maxChildSize: 0.95, // Maximum height
              builder: (context, scrollController) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: const Text(
                            'Fill in these Details',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Email Text Field
                        const Text(
                          'Email',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),

                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Phone Number Text Field
                        const Text(
                          'Phone Number',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),

                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Dropdown for Full Name
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

                        // Password Text Field
                        const Text(
                          'Password',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),

                        TextField(
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
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

                        // Confirm Password Text Field
                        const Text(
                          'Confirm Password',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),

                        TextField(
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Sign Up Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_selectedName == 'Residential User') {
                                GoRouter.of(context).go('/home');
                              } else {
                                // Handle sign-up for other roles
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please sign up as a Residential User to proceed'),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Pallete.mainDashColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Sign Up',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
