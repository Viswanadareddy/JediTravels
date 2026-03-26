import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'constants.dart';
import 'datetime_picker_widget.dart';
import 'services/api_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class PaymentsPage extends StatefulWidget {
  const PaymentsPage({
    Key? key,
     this.hotelId, 
    required this.price,
    required this.hotelname,
    }) : super(key: key);
    final int? hotelId;
  final String price;
  final String hotelname;

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  late Razorpay razerPay;
  final ApiService _apiService = ApiService();

   final TextEditingController _guestsController =
      TextEditingController(text: '1');

  final TextEditingController _offerCodeController =
      TextEditingController();

  DateTime? checkInDateTime;
  DateTime? checkOutDateTime;

  bool _isLoadingQuote = false;
  Map<String, dynamic>? _quote;
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
    _guestsController.dispose();
  _offerCodeController.dispose();
    razerPay.clear();
    super.dispose();
  }

  Future<void> _getQuote() async {
  if (widget.hotelId == null || widget.hotelId == 0) {
    showMessage('Pricing quote is available in backend hotel mode');
    return;
  }

  if (checkInDateTime == null || checkOutDateTime == null) {
    showMessage('Please select both check-in and check-out time');
    return;
  }

  final int guests = int.tryParse(_guestsController.text.trim()) ?? 1;
 String offerCode = _offerCodeController.text.trim().toUpperCase();

  setState(() {
    _isLoadingQuote = true;
  });

  try {
    final result = await _apiService.getPricingQuote(
      hotelId: widget.hotelId!,
      checkIn: DateFormat('yyyy-MM-dd').format(checkInDateTime!),
      checkOut: DateFormat('yyyy-MM-dd').format(checkOutDateTime!),
      guests: guests,
      offerCode: offerCode,
    );

    setState(() {
      _quote = result;
    });

    showMessage('Pricing quote loaded');
  } catch (e) {
    showMessage('Failed to get pricing quote');
  } finally {
    setState(() {
      _isLoadingQuote = false;
    });
  }
}

Future<void> _pasteOfferCode() async {
  final data = await Clipboard.getData('text/plain');
  final pasted = data?.text?.trim() ?? '';

  if (pasted.isEmpty) {
    showMessage('Clipboard is empty');
    return;
  }

  setState(() {
    _offerCodeController.text = pasted;
  });

  showMessage('Offer code pasted');
}

double _amountToPay() {
  if (_quote != null && _quote!['final_total'] != null) {
    return (_quote!['final_total'] as num).toDouble();
  }

  return double.tryParse(widget.price.trim()) ?? 0;
}
void openCheckout() {
  final parsedPrice = _amountToPay();
if (kIsWeb) {
  showMessage('Web payment is not enabled yet. Please use the mobile app.');
  return;
}
  if (parsedPrice <= 0) {
    debugPrint('Invalid payable amount: $parsedPrice');
    showMessage('Invalid payable amount');
    return;
  }

  final options = {
    "key": "rzp_test_STzl7u7j2D40D2",
    "amount": (parsedPrice * 100).toInt(),
    "name": 'Booking the hotel',
    'description': 'Pay for ${widget.hotelname}',
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
    showMessage('Razorpay failed to open');
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
          'price' : _amountToPay().toStringAsFixed(2),
          'quote' : _quote,
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
    showMessage(
      'Payment failed: ${response.code} - ${response.message}');
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    print('Wallet gateway successful');
  }

Widget _quoteSection() {
  if (_isLoadingQuote) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  if (_quote == null) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text('Get a quote to see total amount'),
    );
  }

  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _quoteRow('Hotel', _quote!['hotel_name'].toString()),
          _quoteRow('Nights', _quote!['nights'].toString()),
          _quoteRow('Guests', _quote!['guests'].toString()),
          _quoteRow('Base/night', '\$${_quote!['base_price_per_night']}'),
          _quoteRow('Subtotal', '\$${_quote!['subtotal']}'),
          _quoteRow('Extra guest charge', '\$${_quote!['extra_guest_charge']}'),
          if (_quote!['offer_code'] != null)
             _quoteRow('Offer Code', _quote!['offer_code'].toString()),

           if (_quote!['offer_title'] != null)
             _quoteRow('Offer', _quote!['offer_title'].toString()),
          _quoteRow('Discount', '- \$${_quote!['discount_amount']}'),
          const Divider(),
          _quoteRow('Final total', '\$${_quote!['final_total']}', isBold: true),
        ],
      ),
    ),
  );
}

Widget _quoteRow(String label, String value, {bool isBold = false}) {
  final style = TextStyle(
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    fontSize: isBold ? 16 : 14,
  );

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Expanded(child: Text(label, style: style)),
        Text(value, style: style),
      ],
    ),
  );
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
      body: SingleChildScrollView(
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
            Padding(
  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
  child: TextField(
    controller: _guestsController,
    keyboardType: TextInputType.number,
    decoration: const InputDecoration(
      labelText: 'Number of Guests',
      border: OutlineInputBorder(),
    ),
  ),
),
Padding(
  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
  child: Row(
    children: [
      Expanded(
        child: TextField(
          controller: _offerCodeController,
          decoration: const InputDecoration(
            labelText: 'Offer Code',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      const SizedBox(width: 10),
      ElevatedButton(
        onPressed: _pasteOfferCode,
        child: const Text('Paste'),
      ),
    ],
  ),
),
Center(
  child: ElevatedButton(
    onPressed: _getQuote,
    style: ElevatedButton.styleFrom(
      backgroundColor: Constants.buttonColor,
    ),
    child: const Text(
      'Get Pricing Quote',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
_quoteSection(),
Padding(
  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
  child: Text(
    'Amount to pay now: \$${_amountToPay().toStringAsFixed(2)}',
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Constants.textColor,
    ),
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
                      showMessage(
                          'Please select both check-in and check-out time'
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
