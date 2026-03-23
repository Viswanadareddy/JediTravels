import 'package:flutter/material.dart';
import 'package:loginout/constants.dart';
import 'package:loginout/login.dart';
import 'package:loginout/registration.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Constants.offWhite,
      body: Column(
        children: [
          // Top section — full bleed image with gradient
          Stack(
            children: [
              // Background image
              SizedBox(
                width: double.infinity,
                height: size.height * 0.55,
                child: Image.asset(
                  'assets/start.jpeg',
                  fit: BoxFit.cover,
                ),
              ),

              // Gradient overlay bottom of image
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 120,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Constants.offWhite,
                      ],
                    ),
                  ),
                ),
              ),

              // JediTravels logo top left
              Positioned(
                top: 48,
                left: 24,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Constants.deepNavy.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'JediTravels ✈',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Bottom section — text and buttons
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // Title
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Welcome to ',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: Constants.darkText,
                          ),
                        ),
                        TextSpan(
                          text: 'JediTravels',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Constants.deepNavy,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Subtitle
                  Text(
                    'Find and book the perfect hotel for your next adventure.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Constants.mutedText,
                      height: 1.5,
                    ),
                  ),

                  const Spacer(),

                  // Sign In button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.deepNavy,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Register button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(
                          color: Constants.deepNavy,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          color: Constants.deepNavy,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Terms note
                  Center(
                    child: Text(
                      'By continuing you agree to our Terms & Privacy Policy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: Constants.mutedText,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}