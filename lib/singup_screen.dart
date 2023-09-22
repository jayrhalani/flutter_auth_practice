import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _dateOfBirth = '';
  String _password = '';
  String _confirmPassword = '';

  final _dateOfBirthController = TextEditingController();
  DateTime initialDate = DateTime.now();

  bool _validateFirstName() {
    return _firstName.isNotEmpty;
  }

  bool _validateLastName() {
    return _lastName.isNotEmpty;
  }

  bool _validateEmail() {
    RegExp emailValidator =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailValidator.hasMatch(_email);
  }

  String? _validatePassword() {
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

  String? _validateConfirmPassword() {
    if (_confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }
    if (_password != _confirmPassword) {
      return 'Passwords do not match';
    }
    return null; // Return null if the confirmation is valid
  }

  String? _validateDateOfBirth() {
    if (_dateOfBirth.isEmpty) {
      return 'Please select your birth date';
    }
    return null; // Return null if the confirmation is valid
  }

  void _navigateToLoginScreen(BuildContext context) {
    // After successful signup, navigate back to the login screen.
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16.0,
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  iconSize: 28,
                  onPressed: () {
                    setState(() {
                      _navigateToLoginScreen(context);
                    });
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Signup",
                        style: TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold),
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
                          prefixIcon: Icon(Icons.person),
                          hintText: "First Name",
                          hintStyle: TextStyle(letterSpacing: 1, fontSize: 16),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        validator: (value) {
                          if (!_validateFirstName()) {
                            return 'Please enter First name.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _firstName = value;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(fontSize: 16, letterSpacing: 1),
                        decoration: const InputDecoration(
                          filled: true,
                          prefixIcon: Icon(Icons.person),
                          hintText: "Last Name",
                          hintStyle: TextStyle(letterSpacing: 1, fontSize: 16),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        validator: (value) {
                          if (!_validateLastName()) {
                            return 'Please enter Last name.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _lastName = value;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(fontSize: 16, letterSpacing: 1),
                        decoration: const InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.mail),
                            hintText: "Email",
                            hintStyle:
                                TextStyle(letterSpacing: 1, fontSize: 16),
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
                        readOnly: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(fontSize: 16, letterSpacing: 1),
                        decoration: const InputDecoration(
                          filled: true,
                          prefixIcon: Icon(Icons.calendar_today_rounded),
                          hintText: "Date of birth",
                          hintStyle: TextStyle(letterSpacing: 1, fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        validator: (value) {
                          return _validateDateOfBirth();
                        },
                        onChanged: (value) {
                          _dateOfBirth = value;
                        },
                        controller: _dateOfBirthController,
                        onTap: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: initialDate,
                            firstDate: DateTime(1900, 1, 1),
                            lastDate: DateTime.now(),
                          );
                          if (selectedDate != null) {
                            initialDate = selectedDate;
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(selectedDate);
                            _dateOfBirthController.text = formattedDate;
                            _dateOfBirth = formattedDate;
                          }
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
                          return _validatePassword();
                        },
                        onChanged: (value) {
                          _password = value;
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
                            hintText: "Confirm Password",
                            hintStyle:
                                const TextStyle(letterSpacing: 1, fontSize: 16),
                            filled: true,
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            suffixIcon: IconButton(
                                icon: Icon(confirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    confirmPasswordVisible =
                                        !confirmPasswordVisible;
                                  });
                                })),
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        obscureText: confirmPasswordVisible,
                        validator: (value) {
                          return _validateConfirmPassword();
                        },
                        onChanged: (value) {
                          _confirmPassword = value;
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
                              content: Text('Yay! Signup Successful!'),
                              duration: Duration(seconds: 30),
                            ));
                            _navigateToLoginScreen(context);
                          }
                        },
                        child: const Text('Signup',
                            style: TextStyle(
                                color: Colors.white, letterSpacing: 1)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
