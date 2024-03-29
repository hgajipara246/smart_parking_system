// ignore_for_file: non_constant_identifier_names

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:smart_parking_system/res/common/app_button/main_button.dart';
import 'package:smart_parking_system/view/booking/booking_page.dart';
import 'package:smart_parking_system/view/booking/date_selection.dart';

class PaymentScreen extends StatefulWidget {
  final String? title;
  final String? data;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final int? timeDifference;
  final String? selectedDate;

  const PaymentScreen({super.key, this.title, this.data, this.startTime, this.endTime, this.timeDifference, this.selectedDate});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int? total;
  int ratePerHour = 40;
  int selectedHours = 1;

  void savePaymentDetails() async {
    try {
      // Access Firebase Firestore
      final CollectionReference paymentCollection = FirebaseFirestore.instance.collection('payments');

      // Calculate total if not calculated before
      if (total == null) {
        total = ratePerHour * selectedHours;
      }

      // Create a new document with a generated ID
      await paymentCollection.add({
        'selectedDate': widget.selectedDate,
        'startTime': _formatTimeOfDay(widget.startTime),
        'endTime': _formatTimeOfDay(widget.endTime),
        'totalHour': widget.timeDifference,
        'price': ratePerHour,
        'total': total,
      });

      // Show success message or navigate to another screen
      showAlertDialog(
        context,
        "Payment Successful",
        "Your payment details have been saved.",
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok'),
          ),
        ],
      );
    } catch (e) {
      print("Error saving payment: $e");
      // Show error message
      showAlertDialog(
        context,
        "Error",
        "Failed to save payment details.",
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Ok'),
          ),
        ],
      );
    }
  }

  @override
  void initState() {
    total = ratePerHour * selectedHours;
    if (kDebugMode) {
      print("Price value  ---->< ${widget.data}");
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
      appBar: AppBar(
        backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
        leading: BackButton(
          color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
        ),
        elevation: 0,
        title: Text(
          "Payment",
          style: TextStyle(
            color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Finish your payment with multi payment Option and conform your parking slot..",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                buildPaymentDetails(),
                const SizedBox(height: 45),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/payment/upi-icon.png",
                          height: 60,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                        Image.asset(
                          "assets/images/payment/visa-icon.png",
                          height: 60,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                        Image.asset(
                          "assets/images/payment/mastercard-icon.png",
                          height: 40,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/payment/googlepay-icon.png",
                          height: 25,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Image.asset(
                          "assets/images/payment/paytm-icon.png",
                          height: 30,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Image.asset(
                          "assets/images/payment/phonepe-icon.png",
                          height: 25,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 45),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: MainButton(
                        textName: "Payment",
                        textColor: AdaptiveTheme.of(context).mode.isDark ? Colors.white : const Color(0xff001128),
                        backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.grey[800] : const Color(0xffe4ebff),
                        mainOnPress: () {
                          int totalAmountPaisa = (ratePerHour * selectedHours).toInt();
                          print(totalAmountPaisa);

                          Razorpay razorpay = Razorpay();

                          var options = {
                            'key': 'rzp_test_cYIYutCiDu13Ut',
                            "currency": "INR",
                            "amount": totalAmountPaisa * 100,
                            'name': 'Automate Park',
                            'description': 'Pay for automate park system',
                            "theme.color": "#F1F8FF",
                            'retry': {'enabled': true, 'max_count': 1},
                            'send_sms_hash': true,
                            'prefill': {'contact': '9613811624', 'email': 'harshilgajipara006@gmail.com'},
                            'external': {
                              'wallets': ['paytm'],
                            },
                          };

                          razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                          razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
                          razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
                          razorpay.open(options);
                          savePaymentDetails();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    showAlertDialog(
      context,
      "Payment Failed",
      "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}",
      actions: [
        TextButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Color(0x80102A5B),
            ),
          ),
          child: const Text(
            'Ok',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DateSelectionPage(),
              ),
            );
          },
        ),
      ],
    );
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: QrImageView(data: "data"),
          content: Text(
            'Your Payment is Done\n\nPayment ID: ${response.paymentId}\n\nPlease Show This Barcode On camera to open get.',
          ),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  AdaptiveTheme.of(context).mode.isDark ? const Color.fromRGBO(241, 248, 255, 1) : Color(0xff080d65),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookingPage(),
                  ),
                );
              },
              child: Text(
                'Ok',
                style: TextStyle(
                  color: AdaptiveTheme.of(context).mode.isDark ? const Color(0xff080d65) : Color.fromRGBO(241, 248, 255, 1),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
      context,
      "External Wallet Selected",
      "${response.walletName}",
      actions: <Widget>[
        TextButton(
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Color(0x80102A5B),
            ),
          ),
          child: const Text(
            'Continue',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DateSelectionPage(),
              ),
            );
          },
        ),
      ],
    );
  }

  void showAlertDialog(BuildContext context, String title, String message, {required List<Widget> actions}) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          Color(0x80102A5B),
        ),
      ),
      child: const Text(
        "Continue",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DateSelectionPage(),
          ),
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget buildPaymentDetails() {
    selectedHours = widget.timeDifference!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Payment Details",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        buildDetailItem(
          "Slot No.",
          "${widget.title} slot",
        ),
        buildDetailItem("Date", "${widget.selectedDate}"),
        buildDetailItem("Start Time", _formatTimeOfDay(widget.startTime)),
        buildDetailItem("End Time", _formatTimeOfDay(widget.endTime)),
        buildDetailItem("Time Difference", "${widget.timeDifference} hours"),
        buildDetailItem("Price (per hour)", "₹ 40"),
        const Divider(color: Colors.grey),
        buildDetailItem("Total", "₹ ${total = ratePerHour * selectedHours}"),
      ],
    );
  }

  String _formatTimeOfDay(TimeOfDay? time) {
    if (time == null) return '';
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  Widget buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
// 'amount': "$totalAmountPaisa",
// "amount": 50000,
// 'amount': "₹ ${total = ratePerHour * selectedHours}",
// 'amount': "${total! * 100}",
// 'amount': "10000000",
// 'amount': (double.parse(widget.Data!) * 100),
