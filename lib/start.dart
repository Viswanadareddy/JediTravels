import 'package:flutter/material.dart';
import 'package:loginout/login.dart';
import 'package:loginout/registration.dart';
import 'constants.dart';
//import 'package:flutter_signin_button/flutter_signin_button.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 35,
            ),
            Container(
              height: 300,
              child: Image(
                image: AssetImage("assets/start.jpeg"),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 20,
            ),
            RichText(
              text: TextSpan(
                  text: 'Welcome to ',
                  style: TextStyle(
                      color: Constants.textColor,
                      fontSize: 27,
                      fontWeight: FontWeight.normal),
                  children: [
                    TextSpan(
                        text: 'Jedi Travels',
                        style: TextStyle(
                            color: Constants.extraColor,
                            fontSize: 33,
                            fontWeight: FontWeight.w900))
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Best Hotel Booking App',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Constants.kTextColor),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.buttonColor),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Constants.textColor,
                      ),
                    )),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register(),
                        ));
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Constants.buttonColor),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Constants.textColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
