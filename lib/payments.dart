import 'package:flutter/material.dart';
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
  void showMessage(String message){
    if (!mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
  }

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
    final parsedPrice = double.tryParse(widget.price.trim());

if (parsedPrice == null) {
  debugPrint('Invalid price string: ${widget.price}');
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Invalid price: ${widget.price}')),
  );
  return;
}

    final options = {
      "key": "rzp_test_STzl7u7j2D40D2",
      "amount": (parsedPrice * 100).toInt(),
      "name": 'Booking the hotel',
      'description': 'Pay the money',
      'prefill': {'email': 'test@example.com', 'contact': '9999999999'},
      'external': {
        'wallets': ['paytm']
      }
    };

    debugPrint('Opening Razorpay with options: $options');
    try {
      
      razerPay.open(options);
      debugPrint('Returned from Razorpay.open call');
    } catch (e, st) {
      debugPrint('Razorpay open error: $e');
      debugPrint('$st');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Razorpay failed to open')),
    );
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
      showMessage('Hotel Booked Successfully!');
    }
  }

  void handlerPaymentError(PaymentFailureResponse response) {
    //Navigator.pop(context);
    debugPrint('Razorpay payment error code: ${response.code}');
  debugPrint('Razorpay payment error message: ${response.message}');
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Payment failed: ${response.code} - ${response.message}'),
    ),
  );
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    print('Wallet gateway successful');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Constants.deepNavy,
        foregroundColor: Colors.white,
        title: const Text(
          'Payment Gateway',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
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
              child: DatetimePickerWidget(
                title: 'DateTime',
                onChanged: (value){
                  setState(() {
                    checkInDateTime= value;
                  });
                },
              ),
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
              child: DatetimePickerWidget(
                title: 'DateTime',
                onChanged: (value){
                  setState(() {
                    checkOutDateTime = value;
                  });
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  debugPrint('Pay tapped');
  debugPrint('hotel: ${widget.hotelname}');
  debugPrint('price raw: ${widget.price}');
  debugPrint('checkInDateTime: $checkInDateTime');
  debugPrint('checkOutDateTime: $checkOutDateTime');
                    if(checkInDateTime==null|| checkOutDateTime ==null){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select both check-in and check-out time'),
                      ),
                      );
                      return;
                    }
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
