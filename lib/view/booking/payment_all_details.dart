import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:smart_parking_system/model/parking_model.dart';
import 'package:ticket_widget/ticket_widget.dart';

class PaymentAllDetails extends StatefulWidget {
  final PaymentModel payment;

  const PaymentAllDetails({Key? key, required this.payment}) : super(key: key);

  @override
  State<PaymentAllDetails> createState() => _PaymentAllDetailsState();
}

class _PaymentAllDetailsState extends State<PaymentAllDetails> {
  FirebaseAuth? firebaseAuth;
  FirebaseFirestore? firebaseFirestore;
  FirebaseStorage? firebaseStorage;

  UserModel userModel = UserModel();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    firebaseAuth = FirebaseAuth.instance;
    firebaseFirestore = FirebaseFirestore.instance;
    firebaseStorage = FirebaseStorage.instance;
    getUser();
  }

  void getUser() {
    CollectionReference users = firebaseFirestore!.collection("user");
    users.doc(firebaseAuth!.currentUser!.uid).get().then((value) {
      debugPrint("User Home  --------> ${jsonEncode(value.data())}");
      userModel = userModelFromJson(jsonEncode(value.data()));
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      debugPrint("Failed to get user  : $error");
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
      appBar: AppBar(
        backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
        title: const Text('Payment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TicketWidget(
          width: 350,
          height: 600,
          isCornerRounded: true,
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 120.0,
                      height: 25.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(width: 1.0, color: Colors.green),
                      ),
                      child: Center(
                        child: Text(
                          'Slot No. : ${widget.payment.slotNumber}',
                          style: const TextStyle(color: Colors.green),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Colors.pink,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "${userModel.city}",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    'Slot Booking Ticket',
                    style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Image.network(
                      widget.payment.qrCodeUrl,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Text(
                  textAlign: TextAlign.center,
                  'Please scan your Parking QR Code on the scanner machine to enter.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ticketDetailsWidget('Booker', '${userModel.name}', 'Date', '${widget.payment.selectedDate}'),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, right: 5.0),
                        child: ticketDetailsWidget('Car Number Plate', '${userModel.carNumberPlate}', 'Mobile No.', '${userModel.phoneNumber}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, right: 20.0),
                        child: ticketDetailsWidget('Start Time', '${widget.payment.startTime}', 'End Time', '${widget.payment.endTime}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, right: 20.0),
                        child: ticketDetailsWidget('Price (per hour)         ', '40', 'Total price', '${widget.payment.total}'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ticketDetailsWidget(String firstTitle, String firstDesc, String secondTitle, String secondDesc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                firstTitle,
                style: const TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  firstDesc,
                  style: const TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                secondTitle,
                style: const TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  secondDesc,
                  style: const TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
