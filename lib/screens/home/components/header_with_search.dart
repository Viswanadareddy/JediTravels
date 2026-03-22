import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';

import 'package:loginout/constants.dart';

class HeaderWithSearchBox extends StatelessWidget {
  const HeaderWithSearchBox({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Constants.kDefaultPadding * 2.5),
      height: size.height * 0.25,
      child: Stack(
        children: <Widget>[
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.only(
              left: Constants.kDefaultPadding,
              right: Constants.kDefaultPadding,
              bottom: 36 + Constants.kDefaultPadding,
              top: 15,
            ),
            height: size.height * 0.3 - 27,
            decoration: BoxDecoration(
              color: Constants.buttonColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Text(
                  'Welcome user!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Constants.textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 26,
                      ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin:
                  EdgeInsets.symmetric(horizontal: Constants.kDefaultPadding),
              padding:
                  EdgeInsets.symmetric(horizontal: Constants.kDefaultPadding),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Constants.kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        icon: Icon(Icons.search),
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: Constants.kPrimaryColor,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
