import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginout/constants.dart';
import 'package:loginout/screens/home/home_screen.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth = FirebaseAuth.instance;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _passwordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await newUser.user?.updateDisplayName(_nameController.text.trim());

      await FirebaseFirestore.instance
          .collection('users')
          .doc(newUser.user!.uid)
          .set({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'uid': newUser.user!.uid,
        'createdAt': DateTime.now().toIso8601String(),
      });

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_getFriendlyError(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _getFriendlyError(String error) {
    if (error.contains('email-already-in-use')) {
      return 'An account already exists with this email';
    }
    if (error.contains('weak-password')) {
      return 'Password must be at least 6 characters';
    }
    if (error.contains('invalid-email')) {
      return 'Please enter a valid email address';
    }
    return 'Registration failed. Please try again';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Constants.offWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              height: size.height * 0.28,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Constants.deepNavy,
                    Constants.oceanBlue,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Create Account ✈',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Join JediTravels today',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),

            // Form
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // Name
                  _buildLabel('Full Name'),
                  _buildField(
                    controller: _nameController,
                    hint: 'Viswanada Reddy',
                    icon: Icons.person_outline,
                  ),

                  const SizedBox(height: 16),

                  // Email
                  _buildLabel('Email Address'),
                  _buildField(
                    controller: _emailController,
                    hint: 'you@example.com',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 16),

                  // Password
                  _buildLabel('Password'),
                  _buildPasswordField(),

                  const SizedBox(height: 28),

                  // Register button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.deepNavy,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Create Account',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Login link
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(color: Constants.mutedText),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Constants.oceanBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Constants.darkText,
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Constants.cardWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Constants.darkText),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Constants.mutedText),
          prefixIcon: Icon(icon, color: Constants.oceanBlue),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Constants.cardWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _passwordController,
        obscureText: !_passwordVisible,
        style: const TextStyle(color: Constants.darkText),
        decoration: InputDecoration(
          hintText: '••••••••',
          hintStyle: TextStyle(color: Constants.mutedText),
          prefixIcon: const Icon(
            Icons.lock_outline,
            color: Constants.oceanBlue,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Constants.mutedText,
            ),
            onPressed: () =>
                setState(() => _passwordVisible = !_passwordVisible),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}