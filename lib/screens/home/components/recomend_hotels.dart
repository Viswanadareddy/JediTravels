import 'package:flutter/material.dart';
import 'package:loginout/hotel_details.dart';

import 'package:loginout/constants.dart';

class RecommendedHotels extends StatelessWidget {
  const RecommendedHotels({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          recomend_hotels.length,
          (index) => GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HotelDetailsPage(
                            image: recomend_hotels[index].image,
                            hotelname: recomend_hotels[index].hotelname,
                            location: recomend_hotels[index].location,
                            price: recomend_hotels[index].price.toString(),
                            rating: recomend_hotels[index].rating,
                          )));
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20, left: index == 0 ? 20 : 0),
              child: RecommendedHotelCard(
                image: recomend_hotels[index].image,
                hotelname: recomend_hotels[index].hotelname,
                location: recomend_hotels[index].location,
                price: recomend_hotels[index].price,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RecommendedHotelCard extends StatelessWidget {
  const RecommendedHotelCard({
    Key? key,
    required this.image,
    required this.hotelname,
    required this.location,
    required this.price,
  }) : super(key: key);

  final String image, hotelname, location;
  final int price;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.6,
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(image)),
          Container(
            padding: EdgeInsets.all(Constants.kDefaultPadding / 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "$hotelname\n".toUpperCase(),
                          style: Theme.of(context).textTheme.labelLarge),
                      TextSpan(
                        text: "$location".toUpperCase(),
                        style: TextStyle(
                          color: Constants.kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text(
                  '\$$price',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(color: Constants.kPrimaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReccommendedModel {
  const ReccommendedModel({
    required this.image,
    required this.hotelname,
    required this.location,
    required this.price,
    required this.rating,
  });
  final String image;
  final String hotelname;
  final String location;
  final int price;
  final String rating;
}

List<ReccommendedModel> recomend_hotels = [
  ReccommendedModel(
      image: 'assets/hotel_images/3.jpeg',
      //image:  'https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?s=1024x768',
      hotelname: 'Luxury Hotels',
      location: 'Africa',
      price: 440,
      rating: '4.5'),
  ReccommendedModel(
      image: 'assets/hotel_images/4.jpeg',
      //image:'https://images.moneycontrol.com/static-mcnews/2019/09/Samhi_Hotels-770x433.jpg?impolicy=website&width=770&height=431',
      hotelname: 'Evangeline Resorts',
      location: 'Russia',
      price: 400,
      rating: '4.9'),
  ReccommendedModel(
      image: 'assets/hotel_images/5.jpeg',
      //image: 'https://www.itchotels.com/content/dam/itchotels/in/umbrella/images/headmast-desktop/welcomhotel-bhubaneswar.jpg',
      hotelname: 'Larry Homes',
      location: 'Europe',
      price: 420,
      rating: '4.7'),
  ReccommendedModel(
      image: 'assets/hotel_images/6.jpeg',
      //image:  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1CjWXiBVqbpnJAGlkf_UCaqBZPGTI0veUIQ&usqp=CAU',
      hotelname: 'Jerry Restaurants',
      location: 'Austrailia',
      price: 430,
      rating: '4.8')
];
