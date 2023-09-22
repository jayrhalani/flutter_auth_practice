import 'package:flutter/material.dart';
import 'package:flutter_auth_practice/singup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<StatefulWidget> {
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = true;
  String _email = '';
  String _password = '';

  bool _validateEmail() {
    RegExp emailValidator =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailValidator.hasMatch(_email);
  }

  String? validatePassword() {
    if (_password.isEmpty) {
      return 'Password is required';
    }
    if (_password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    if (!RegExp(r'^(?=.*[A-Z])').hasMatch(_password)) {
      return 'Password must contain at least one uppercase letter';
    }
    return null; // Return null if the password is valid
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16.0, 128.0, 16.0, 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.stacked_line_chart_rounded, size: 64),
                const SizedBox(height: 16),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing.",
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 36),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(fontSize: 16, letterSpacing: 1),
                  decoration: const InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.mail),
                      hintText: "Email",
                      hintStyle: TextStyle(letterSpacing: 1, fontSize: 16),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10)))),
                  validator: (value) {
                    if (!_validateEmail()) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _email = value;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(fontSize: 16, letterSpacing: 1),
                  decoration: InputDecoration(
                      errorMaxLines: 3,
                      prefixIcon: const Icon(Icons.lock_open),
                      hintText: "Password",
                      hintStyle:
                          const TextStyle(letterSpacing: 1, fontSize: 16),
                      filled: true,
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                      suffixIcon: IconButton(
                          icon: Icon(passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          })),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: passwordVisible,
                  validator: (value) {
                    /*if (!_validatePassword()) {
                      return 'Password must be at least 8 characters long.';
                    }
                    return null;*/
                    return validatePassword();
                  },
                  onChanged: (value) {
                    _password = value;
                  },
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      minimumSize: const Size.fromHeight(60),
                      backgroundColor: Colors.black,
                      elevation: 4),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                        content: Text('Yay! Login Successful!'),
                      ));
                    }
                  },
                  child: const Text('LOGIN',
                      style:
                          TextStyle(color: Colors.white, letterSpacing: 1)),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                      onTap: () {
                        // send to login screen
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignUpScreen()));
                      },
                      child: const Text(
                        "Sign Up Here",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
