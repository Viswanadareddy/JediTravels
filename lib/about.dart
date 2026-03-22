import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Constants.textColor,
            ),
          ),
        ),
        titleSpacing: 0,
        backgroundColor: Constants.buttonColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Constants.textColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Welcome to Jedi Travels!'
                '\n\nBy investing in the technology that helps take the friction out of travel, Jedi Travels  seamlessly connects millions of travellers with memorable experiences, a range of  transport options and incredible places to stay - from homes to hotels and much more. As one of the world’s largest travel marketplaces for both established brands and entrepreneurs of all sizes, Jedi Travels enables properties all over the world to  reach a global audience and grow their businesses.'
                '\n\nJedi Travels is available in 43 languages and offers more than 28 million total  reported accommodation listings, including over 6.2 million listings alone of homes, apartments and other unique places to stay. No matter where you want to go or what you want to do, Jedi Travels makes it easy and backs it all up with 24/7 customer support.'
                '\n\nJedi Travels guarantees to offer you the best available rates. And with our promise to price match, you can rest assured that you’re always getting a great deal.Instant confirmation Here, every reservation is instantly confirmed. Once you’ve found your perfect stay, a few clicks are all it takes.No reservation fees We don’t charge you any booking fees or add any administrative charges. And in many cases, your booking can be cancelled free of charge.'
                '\n\n24/7 support Whether you’ve just booked or are already enjoying your trip, our customer experience team are on hand around the clock to answer your questions and advocate on your behalf in more than 40 languages. Make sure to check out our FAQ for travellers.',
                textAlign: TextAlign.justify,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Constants.textColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*aboutMyApp() {
    showAboutDialog(
        context: context,
        applicationIcon: FlutterLogo(),
        applicationName: 'Hotel Booking',
        applicationVersion: '0.0.1',
        applicationLegalese: 'Developed by Team',
        children: <Widget>[
          Text(
              'By investing in the technology that helps take the friction out of travel, Jedi Travels seamlessly connects millions of travellers with memorable experiences, a range of transport options and incredible places to stay - from homes to hotels and muchmore.'),
          Text(
              'As one of the world’s largest travel marketplaces for both established brands and entrepreneurs of all sizes, Jedi Travels enables properties all over the world to reach a global audience and grow their businesses.'),
          Text(
              'Jedi Travels is available in 43 languages and offers more than 28 million total reported accommodation listings, including over 6.2 million listings alone of homes, apartments and other unique places to stay. No matter where you want to go or what you want to do, Jedi Travels makes it easy and backs it all up with 24/7 customer support.'),
          Text(
              'LOW RATES: Jedi Travels guarantees to offer you the best available rates. And with our promise to price match, you can rest assured that you’re always getting a great deal.'),
          Text(
              'NO RESERVATION FEES: We don’t charge you any booking fees or add any administrative charges. And in many cases, your booking can be cancelled free of charge.'),
          Text(
              '24/7 SUPPORT: Whether you’ve just booked or are already enjoying your trip, our customer experience team are on hand around the clock to answer your questions and advocate on your behalf in more than 40 languages. Make sure to check out our FAQ for travellers.')
        ]);
  }*/
}
