import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({Key? key}) : super(key: key);

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendReset() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _auth.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      if (mounted) {
        setState(() {
          _isLoading = false;
          _emailSent = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.offWhite,
      appBar: AppBar(
        backgroundColor: Constants.deepNavy,
        foregroundColor: Colors.white,
        title: const Text(
          'Reset Password',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _emailSent ? _buildSuccessState() : _buildFormState(),
        ),
      ),
    );
  }

  Widget _buildFormState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),

        // Icon
        Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Constants.deepNavy.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lock_reset,
              size: 40,
              color: Constants.deepNavy,
            ),
          ),
        ),

        const SizedBox(height: 32),

        const Text(
          'Forgot your password?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Constants.deepNavy,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          'Enter your email address and we\'ll send you a link to reset your password.',
          style: TextStyle(
            fontSize: 14,
            color: Constants.mutedText,
            height: 1.6,
          ),
        ),

        const SizedBox(height: 32),

        // Email field
        const Text(
          'Email Address',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Constants.darkText,
          ),
        ),
        const SizedBox(height: 8),
        Container(
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
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Constants.darkText),
            decoration: InputDecoration(
              hintText: 'you@example.com',
              hintStyle: TextStyle(color: Constants.mutedText),
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: Constants.oceanBlue,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
            ),
          ),
        ),

        const SizedBox(height: 28),

        // Send button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _sendReset,
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
                    'Send Reset Link',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),

        const SizedBox(height: 20),

        // Back to login
        Center(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              '← Back to Login',
              style: TextStyle(
                color: Constants.oceanBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 80),

        // Success icon
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Constants.emerald.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.mark_email_read_outlined,
            size: 50,
            color: Constants.emerald,
          ),
        ),

        const SizedBox(height: 32),

        const Text(
          'Check your inbox!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Constants.deepNavy,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          'We sent a password reset link to\n${_emailController.text}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Constants.mutedText,
            height: 1.6,
          ),
        ),

        const SizedBox(height: 40),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Constants.deepNavy,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Back to Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}