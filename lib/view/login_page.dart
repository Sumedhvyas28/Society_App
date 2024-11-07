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

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialTask();
  }

  void initialTask() {
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit();
    notificationServices.getDeviceToken().then(
      (value) async {
        print('device token');
        print(value);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    passwordController.dispose();
    emailController.dispose();
    _passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final h = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
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
          Positioned(
            top: 581,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(14),
              child: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Swipe up',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' to',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    TextSpan(
                      text: '\n' + 'explore the world',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    TextSpan(
                      text: '\n' + 'of Society',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 760,
            left: 50,
            right: 50,
            child: Center(
              child: Icon(
                Icons.arrow_upward,
                size: 40,
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.135,
            minChildSize: 0.135,
            maxChildSize: 0.6,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Rectangle line for dragging
                          Container(
                            width: 100,
                            height: 5,
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Text(
                            'Enter Your Account Details',
                            style: TextStyle(fontSize: 20),
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
                                    fontSize: 16, color: Colors.black),
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
                                  "password":
                                      passwordController.text.toString(),
                                };
                                authViewModel.loginRepo(data, context);
                              }),

                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              GoRouter.of(context).go('/signup');
                            },
                            child: Text(
                              "Don't have an account? Sign Up",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[800]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
