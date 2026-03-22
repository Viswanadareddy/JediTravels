import 'package:flutter/material.dart';

//import 'package:loginout/constants.dart';

import 'package:loginout/hotel_details.dart';

class Popular extends StatelessWidget {
  const Popular({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          popular_hotels.length,
          (index) => GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HotelDetailsPage(
                          image: popular_hotels[index].image,
                          hotelname: popular_hotels[index].hotelname,
                          location: popular_hotels[index].location,
                          price: popular_hotels[index].price.toString(),
                          rating: popular_hotels[index].rating)));
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20, left: index == 0 ? 20 : 0),
              child: PopularCard(
                  image: popular_hotels[index].image,
                  hotelname: popular_hotels[index].hotelname,
                  location: popular_hotels[index].location,
                  price: popular_hotels[index].price),
            ),
          ),
        ),
      ),
    );
  }
}

class PopularCard extends StatelessWidget {
  const PopularCard({
    Key? key,
    required this.image,
    required this.hotelname,
    required this.location,
    required this.price,
  }) : super(key: key);
  final String image;
  final String hotelname;
  final String location;
  final int price;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.6,
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(image),
        ),
      ),
    );
  }
}

class PopularModel {
  const PopularModel({
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

List<PopularModel> popular_hotels = [
  PopularModel(
      image: 'assets/hotel_images/1.jpeg',

      ///image: 'https://pix10.agoda.net/hotelImages/124/1246280/1246280_16061017110043391702.jpg?s=1024x768',
      hotelname: 'Empire Estates',
      location: 'USA',
      price: 420,
      rating: '4.9'),
  PopularModel(
      image: 'assets/hotel_images/2.jpeg',
      //image: 'https://images.pexels.com/photos/1458457/pexels-photo-1458457.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      hotelname: 'Prime Hotels',
      location: 'Germany',
      price: 450,
      rating: '4.6'),
  PopularModel(
      image: 'assets/hotel_images/6.jpeg',

      ///image: 'https://www.ahstatic.com/photos/9399_ho_00_p_1024x768.jpg',
      hotelname: 'Baileys Residence',
      location: 'Europe',
      price: 410,
      rating: '4.7')
];
