import 'package:flutter/cupertino.dart';
//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool val1 = false;
  bool val2 = false;
  onChangeFunction1(bool newValue1) {
    setState(() {
      val1 = newValue1;
    });
  }

  onChangeFunction2(bool newValue2) {
    setState(() {
      val2 = newValue2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
          child: Text('Settings',
              style: TextStyle(fontSize: 22, color: Constants.textColor)),
        ),
        backgroundColor: Constants.buttonColor,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 13.0),
                  child: Text('General',
                      style: TextStyle(
                          color: Constants.textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.normal))),
              customSwitch(
                  'Enable notifications', bool, val1, onChangeFunction1),
              /*customSwitch(
                  'Light Mode / Dark Mode', bool, val2, onChangeFunction2),*/
              Divider(
                color: Constants.textColor,
              ),
              /*ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.person_outline, color: Colors.white),
                title: Text(
                  'Account',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'profile');
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'Notifications',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'notifications');
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'Apperance',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(
                  Icons.lock_open,
                  color: Colors.white,
                ),
                title: Text(
                  'Privacy & Security',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(
                  Icons.support_agent_rounded,
                  color: Colors.white,
                ),
                title: Text(
                  'Help & Support',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
              Divider(),*/
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(
                  Icons.help_outline_outlined,
                  color: Constants.textColor,
                ),
                title: Text(
                  'About',
                  style: TextStyle(color: Constants.textColor),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'about');
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Constants.textColor,
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.security, color: Constants.textColor),
                title: Text(
                  'Terms and Conditions',
                  style: TextStyle(color: Constants.textColor),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'terms_and_conditions');
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Constants.textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

/*GestureDetector buildAccountOption(BuildContext context, String title) {
  return GestureDetector(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 0),
          Icon(Icons.person, color: Colors.white),
          SizedBox(width: 15),
          Text(title,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
          SizedBox(width: 20),
          Icon(Icons.arrow_forward_ios, color: Colors.white)
        ],
      ),
    ),
  );
}
buildAccountOption(context, 'Account'),
            buildAccountOption(context, 'Notifications'),
            buildAccountOption(context, 'Appearance'),
            buildAccountOption(context, 'Privacy & Security'),
            buildAccountOption(context, 'Help & Support'),
            buildAccountOption(context, 'About')*/
Widget customSwitch(String text, bool, val, Function onChangeMethod) {
  return Padding(
    padding: const EdgeInsets.only(top: 7.0, left: 13.0, right: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
                color: Constants.textColor)),
        Spacer(),
        CupertinoSwitch(
            trackColor: Constants.textColor,
            activeColor: Constants.buttonColor,
            value: val,
            onChanged: (newValue) {
              onChangeMethod(newValue);
            })
      ],
    ),
  );
}
