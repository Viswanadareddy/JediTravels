import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginout/constants.dart';

class BookingHistoryScreen extends StatelessWidget{
  const BookingHistoryScreen({Key?key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        backgroundColor: Constants.buttonColor,
        foregroundColor: Constants.textColor,
        automaticallyImplyLeading: true,
      ),
      body: user == null
      ? const Center(child: Text('Please log in to see the bookings'))
      : StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
        .collection('bookings')
        .where('userId', isEqualTo: user.uid)
        .orderBy('bookedAt', descending: true)
        .snapshots(), 
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError){
            return const Center(
              child: Text('Could not load bookings'),
            );
          }

          if(!snapshot.hasData || snapshot.data!.docs.isEmpty){
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.hotel, size:64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No bookings yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Book a hotel to see it here',
                      style: TextStyle(color: Colors.grey),
                      ),
                ],
              ),
              );
          }

          final bookings = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bookings.length,
            itemBuilder: (context, index){
              final booking =
              bookings[index].data() as Map<String, dynamic>;
              return BookingCard(booking: booking);
            },
            );
        },
        ),
    );
  }
}

class BookingCard extends StatelessWidget{
  const BookingCard({Key?key, required this.booking}) :super(key:key);

  final Map<String, dynamic> booking;

  @override
  Widget build(BuildContext context){
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Text(
              booking['hotelName'] ?? 'Unknown Hotel',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Constants.textColor,
              ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Constants.buttonColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '\$${booking['price']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Constants.textColor,
                  ),
                  ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        const Divider(),
        const SizedBox(height: 8),
        _infoRow(Icons.confirmation_number,
        'Payment ID',
        booking['paymentId']?? 'N/A',
        ),
        const SizedBox(height: 8),
        _infoRow(
          Icons.login,
          'Check In',
          _formatDate(booking['checkIn']),
        ),
        const SizedBox(height: 8),
        _infoRow(
          Icons.logout,
          'Check Out',
          _formatDate(booking['checkOut']),
        ),
        const SizedBox(height: 8),
        _infoRow(
          Icons.access_time,
          'Booked On',
          _formatDate(booking['bookedAt']),
        ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16 ,color: Constants.kPrimaryColor),
        const SizedBox(width: 8),
        Text(
          '$label: ',
         style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.grey,
          fontSize: 13,
         ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13),
              overflow: TextOverflow.ellipsis,
              ),
              ),
      ],
      );
  }

  String _formatDate(dynamic dateString) {
    if(dateString ==null) return 'Not set';
    try{
      final date = DateTime.parse(dateString.toString());
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2,'0')}';
    } catch(e){
      return dateString.toString();
    }
  }
}

