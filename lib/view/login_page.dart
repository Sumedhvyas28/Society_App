import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:society_app/constant/pallete.dart';
import 'package:society_app/notification_services.dart';
import 'package:society_app/res/component/round_button.dart';
import 'package:society_app/utils/utils.dart';
import 'package:society_app/view_model/auth_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _isEmailFocused = false;
  bool _isSheetExpanded = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    passwordController.dispose();
    emailController.dispose();
    _passwordFocusNode.dispose();
  }

  void _toggleSheet() {
    setState(() {
      _isSheetExpanded = !_isSheetExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    // Detect if the keyboard is open
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    double formOffset = keyboardHeight > 0
        ? keyboardHeight / 2
        : 0; // Adjust position when keyboard appears

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/img/login_page.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: w,
              height: h * 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Pallete.loginClr1.withOpacity(0.9),
                    Pallete.loginImgClr2.withOpacity(0.7),
                    Pallete.loginImg1Clr3.withOpacity(0.9),
                  ],
                  stops: [0.0, 0.6, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Animated Text (position and content change based on sheet expansion)
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            top: _isSheetExpanded ? h * 0.350 : 600,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(14),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: _isSheetExpanded ? 'Hello,' : 'Swipe up',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: w * 0.08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: _isSheetExpanded ? '' : ' to',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: w * 0.08,
                      ),
                    ),
                    TextSpan(
                      text: _isSheetExpanded
                          ? '\n' + 'Welcome User'
                          : '\n' + 'explore the world',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: w * 0.08,
                      ),
                    ),
                    TextSpan(
                      text: _isSheetExpanded ? '' : '\n' + 'of Society',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: w * 0.08,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Sheet Animation using AnimatedPositioned
          AnimatedPositioned(
            duration: const Duration(milliseconds: 900),
            bottom: _isSheetExpanded ? 0 : -h * 3,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              // Allow scrolling when keyboard appears
              padding: EdgeInsets.only(
                  bottom: keyboardHeight), // Add padding for keyboard
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(w * 0.05), // Dynamic padding
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Enter Your Account Details',
                          style: TextStyle(fontSize: w * 0.06),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          focusNode: _emailFocusNode,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: _isEmailFocused ? null : 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onSubmitted: (value) {
                            Utils.fieldFocusChange(
                                context, _emailFocusNode, _passwordFocusNode);
                          },
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          obscureText: _obscureText,
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
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
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Handle forgot password action
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  fontSize: w * 0.04, color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        RoundButton(
                          title: 'Login',
                          loading: authViewModel.loading,
                          onPressed: () {
                            Map data = {
                              "email": emailController.text.toString(),
                              "password": passwordController.text.toString(),
                            };
                            authViewModel.loginRepo(data, context);
                          },
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            GoRouter.of(context).go('/signup');
                          },
                          child: Text(
                            "Don't have an account? Sign Up",
                            style: TextStyle(
                                fontSize: w * 0.04, color: Colors.grey[800]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Bottom Icon to expand/collapse sheet
          Positioned(
            bottom: _isSheetExpanded ? 0 : 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              width: double.infinity,
              child: Center(
                child: IconButton(
                  icon: Icon(
                    _isSheetExpanded
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    size: w * 0.1, // Dynamic size based on screen width
                  ),
                  onPressed: _toggleSheet,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
