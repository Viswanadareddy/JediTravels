import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constants.dart';
import 'datetime_picker_widget.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({
    Key? key, 
    required this.price,
    required this.hotelname,
    }) : super(key: key);
  final String price;
  final String hotelname;

  @override
  _PaymentsPageState createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  late Razorpay razerPay;
  TextEditingController textEditingController = new TextEditingController();
  DateTime? checkInDateTime;
  DateTime? checkOutDateTime;

  @override
  void initState() {
    super.initState();
    razerPay = Razorpay();
    razerPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razerPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentError);
    razerPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    razerPay.clear();
    super.dispose();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_STzl7u7j2D40D2",
      "amount": num.parse(widget.price) * 100,
      "name": 'Booking the hotel',
      'description': 'Pay the money',
      'prefill': {'email': 'Nikhil', 'contact': '123456789'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      razerPay.open(options);
    } catch (e) {
      print(e);
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse response) async{
    //Previous version
    /*Navigator.pop(context);
    Navigator.pop(context);
    Fluttertoast.showToast(msg: 'Hotel Booked');*/
    try
    {
      final user= FirebaseAuth.instance.currentUser;
      if (user!=null){
        await FirebaseFirestore.instance
        .collection('bookings')
        .add({
          'userId': user.uid,
          'hotelName': widget.hotelname,
          'price' : widget.price,
          'paymentId':response.paymentId,
          'bookedAt':DateTime.now().toIso8601String(),
          'checkIn':checkInDateTime?.toIso8601String(),
          'checkOut':checkOutDateTime?.toIso8601String(),
        });
      }
    } catch(e){
      print('Booking save failed: $e');
    }
    if (mounted){
      Navigator.pop(context);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Hotel Booked Successfully!');
    }
  }

  void handlerPaymentError(PaymentFailureResponse response) {
    Navigator.pop(context);
    Fluttertoast.showToast(msg: 'Error');
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    print('Wallet gateway successful');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.background,
      appBar: AppBar(
        title: Text(
          'Payment Gateway',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Constants.textColor),
        ),
        backgroundColor: Constants.buttonColor,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  "Check-In Time",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Constants.textColor),
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: DatetimePickerWidget(),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  "Check-Out Time",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Constants.textColor),
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: DatetimePickerWidget(),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  openCheckout();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Constants.buttonColor),
                child: Text('Pay Now',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Constants.textColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
