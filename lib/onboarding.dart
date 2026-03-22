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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: PageView.builder(
                itemCount: splashData.length,
                itemBuilder: (context, index) {
                  return _onboardimage(context, splashData[index]['image']!,
                      splashData[index]['text']!);
                },
                controller: _controller,
                onPageChanged: (int newindex) {
                  setState(() {
                    currentIndex = newindex;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(
                    splashData.length,
                    (index) => _pageindicators(
                      context,
                      index == currentIndex ? 100 : 40,
                      index == currentIndex
                          ? Constants.textColor
                          : Constants.buttonColor.withOpacity(0.6),
                    ),
                  ),
                ),
                TextButton(
                  child: Text(
                    currentIndex != splashData.length - 1 ? 'NEXT' : "DONE",
                    style: TextStyle(
                      fontSize: 16,
                      color: Constants.textColor,
                    ),
                  ),
                  onPressed: () {
                    currentIndex != splashData.length - 1
                        ? _controller.nextPage(
                            duration: Duration(microseconds: 250),
                            curve: Curves.easeInOutBack,
                          )
                        : Navigator.pushNamed(context, 'start');
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

Widget _onboardimage(BuildContext context, String image, String text) {
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
}

List<Map<String, String>> splashData = [
  {
    "text": "We are here to serve any time",
    "image": "assets/anytime.jpeg",
  },
  {
    "text": "We take atmost care of our guests at stay",
    "image": "assets/care.jpeg"
  },
  {"text": "Enjoy your stay with us", "image": "assets/enjoy_your_stay.jpeg"},
];
