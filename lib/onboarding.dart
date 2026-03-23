import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'constants.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  PageController _controller = PageController();

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0F2044),
                  Color(0XFF1A5266),
                ],
                ),
            ),
          ),

          //Content
          SafeArea(
            child: Column(
              children: [
                //Skip button top right
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: currentIndex != splashData.length -1
                    ? TextButton(
                      onPressed: () =>
                      Navigator.pushNamed(context, 'start'),
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      )
                      : const SizedBox(height: 44),
                    ),
                    ),

                    // Page view
                    Expanded(
                      child: PageView.builder(
                        controller: _controller,
                        itemCount: splashData.length,
                        onPageChanged: (index){
                          setState(() => currentIndex =index);
                        },
                        itemBuilder: (context, index){
                          return _buildPage(splashData[index]);
                        },
                        ),
                        ),

                        //Bottom section - dots and button
                        Padding(
                          padding: const EdgeInsetsGeometry.fromLTRB(24,0, 24, 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Dot indiactors
                              Row(
                                children: List.generate(
                                  splashData.length, 
                                  (index) => AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.only(right: 6),
                                    width: index == currentIndex ? 24 : 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: index == currentIndex
                                      ? Constants.emerald
                                      : Colors.white30,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    ),
                                  ),
                              ),

                              // Next / Get Started button
                              GestureDetector(
                                onTap: (){
                                  if(currentIndex != splashData.length -1){
                                    _controller.nextPage(
                                      duration: const Duration(milliseconds: 400), 
                                      curve: Curves.easeInOut
                                      );
                                  } else{
                                    Navigator.pushNamed(context, 'start');
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 28,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Constants.emerald,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Constants.emerald.withOpacity(0.4),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    currentIndex != splashData.length -1
                                    ? 'Next →'
                                    : 'Get Started',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          ),
              ],
            ),
            ),
        ],
      )
    );
  }
}

// Previous Version
/*Widget _onboardimage(BuildContext context, String image, String text) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 350,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          image,
          fit: BoxFit.contain,
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 20),
      Text(
        'Available 24/7.We take atmost care to ensure our guests are satisified with our stay.We ensure every room is sterilized and safe',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    ],
  );
}

Widget _pageindicators(BuildContext context, double width, Color color) {
  return AnimatedContainer(
    margin: const EdgeInsets.fromLTRB(0, 8, 6, 8),
    duration: Duration(microseconds: 250),
    width: width,
    height: 5,
    decoration: BoxDecoration(
      color: color,
    ),
  );
}*/

Widget _buildPage(Map<String, String> data){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image in a frosted card
        Container(
          width: double.infinity,
          height: 260,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.asset(
              data['image']!,
              fit: BoxFit.cover
              ),
          ),
        ),

        const SizedBox(height: 40),

        // Title
        Text(
          data['title']!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
          ),

          const SizedBox(height: 16),

          //Subtitle
          Text(data['text']!,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 15,
            height: 1.6,
          ),
          )
      ],
    ),
    );
}


List<Map<String, String>> splashData = [
  {
    'title': 'Discover Your\nPerfect Stay',
    'text':
        'Browse thousands of hotels worldwide with guaranteed best prices',
    'image': 'assets/anytime.jpeg',
  },
  {
    'title': 'We Care About\nYour Comfort',
    'text':
        'Every hotel is verified. Every room is clean, safe and ready for you',
    'image': 'assets/care.jpeg',
  },
  {
    'title': 'Book in Seconds,\nEnjoy Forever',
    'text':
        'Instant confirmation. No hidden fees. Cancel anytime with one tap',
    'image': 'assets/enjoy_your_stay.jpeg',
  },
];
