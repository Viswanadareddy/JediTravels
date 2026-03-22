import 'package:flutter/material.dart';
import 'package:loginout/constants.dart';

class Offers extends StatefulWidget {
  const Offers({Key? key}) : super(key: key);

  @override
  _OffersState createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offers',
            style: TextStyle(fontSize: 22, color: Constants.textColor)),
        automaticallyImplyLeading: false,
        backgroundColor: Constants.buttonColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 15),
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset('assets/offers/first.jpeg')),
              SizedBox(height: 15),
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset('assets/offers/second.jpeg')),
              SizedBox(height: 15),
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset('assets/offers/third.jpeg')),
            ],
          ),
        ),
      ),
    );
  }
}
