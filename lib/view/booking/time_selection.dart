import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_parking_system/view/booking/payment_screen.dart';

import '../../res/common/app_button/main_button.dart';

class TimeSelectionPage extends StatefulWidget {
  final DateTime selectedDate;
  final int? slotNumber;

  const TimeSelectionPage({Key? key, required this.selectedDate, this.slotNumber}) : super(key: key);

  @override
  State<TimeSelectionPage> createState() => _TimeSelectionPageState();
}

class _TimeSelectionPageState extends State<TimeSelectionPage> {
  late DateTime? _storedDate;
  bool _isLoading = true;

  TimeOfDay _startTime = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 0);

  void _bookAppointment() async {
    try {
      // Get current user
      String? uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid != null) {
        await FirebaseFirestore.instance.collection('bookings').doc(uid).set({
          'selectedDate': widget.selectedDate,
          'startTime': _startTime.format(context),
          'endTime': _endTime.format(context),
          'totalHours': _calculateTimeDifference(_startTime, _endTime),
          'slotNumber': widget.slotNumber,
        });
      }
    } catch (e) {
      debugPrint('Error booking appointment: $e');
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error booking appointment. Please try again.'),
        ),
      );
    }
  }

  Future<void> fetchStoredDate() async {
    try {
      // Get current user
      String? uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid != null) {
        DocumentSnapshot userBookingSnapshot = await FirebaseFirestore.instance.collection('bookings').doc(uid).get();
        Map<String, dynamic>? data = userBookingSnapshot.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey("selectedDate")) {
          Timestamp timestamp = data["selectedDate"] as Timestamp;
          _storedDate = timestamp.toDate();
        }
      }
    } catch (e) {
      print('Error fetching stored date: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    print("Slot Number is : ${widget.slotNumber}");
    fetchStoredDate();
  }

  void _selectStartTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (newTime != null) {
      // Check if the selected time is in the past
      if (_isTimeInPast(newTime)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a future time for Start Time.'),
          ),
        );
      } else {
        setState(() {
          _startTime = newTime;
        });
      }
    }
  }

  void _selectEndTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (newTime != null) {
      // Check if the selected time is in the past
      if (_isTimeInPast(newTime)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a future time for End Time.'),
          ),
        );
      } else {
        setState(() {
          _endTime = newTime;
        });
      }
    }
  }

  bool _isTimeInPast(TimeOfDay time) {
    final now = DateTime.now();
    final selectedDateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return selectedDateTime.isBefore(now);
  }

  int _calculateTimeDifference(TimeOfDay startTime, TimeOfDay endTime) {
    final start = DateTime(2021, 1, 1, startTime.hour, startTime.minute);
    final end = DateTime(2021, 1, 1, endTime.hour, endTime.minute);
    final difference = end.difference(start).inHours;
    return difference;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
      appBar: AppBar(
        backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
        title: Text(
          'Time Selection',
          style: TextStyle(
            fontFamily: "Lato",
            color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Time for \n${DateFormat('MMM dd, yyyy').format(widget.selectedDate)}",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: "Lato",
                          fontWeight: FontWeight.bold,
                          color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: AdaptiveTheme.of(context).mode.isDark ? Colors.white24 : const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildTimeButton("Start Time", _startTime, _selectStartTime),
                                  _buildTimeButton("End Time", _endTime, _selectEndTime),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildTimeDisplay("Start Time", _startTime),
                                  _buildTimeDisplay("End Time", _endTime),
                                ],
                              ),
                              const SizedBox(height: 20),
                              _buildTimeDifference(context),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            size: 19,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Please first select start and end time properly,\nafter make payment",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: 75),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: MainButton(
                            mainOnPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentScreen(
                                      slotNumber: widget.slotNumber,
                                      startTime: _startTime,
                                      endTime: _endTime,
                                      selectedDate: DateFormat('MMM dd, yyyy').format(widget.selectedDate),
                                      timeDifference: _calculateTimeDifference(_startTime, _endTime),
                                    ),
                                  ));
                              _bookAppointment();
                            },
                            textName: "Make Payment",
                            fontSize: 17,
                            textColor: AdaptiveTheme.of(context).mode.isDark ? Colors.white : const Color(0xff001128),
                            backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.grey[800] : const Color(0xffe4ebff),
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

  Widget _buildTimeButton(String title, TimeOfDay time, void Function(BuildContext) onPressed) {
    return ElevatedButton(
      onPressed: () => onPressed(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.grey[800] : const Color.fromRGBO(241, 248, 255, 1),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.access_time,
            color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeDisplay(String title, TimeOfDay time) {
    final formattedTime = DateFormat('h:mm a').format(DateTime(2021, 1, 1, time.hour, time.minute));

    late IconData icon;

    if (title == "Start Time") {
      icon = CupertinoIcons.car_detailed;
    } else if (title == "End Time") {
      icon = Icons.local_parking_rounded;
    }

    final selectedDateTime = DateTime(widget.selectedDate.year, widget.selectedDate.month, widget.selectedDate.day, time.hour, time.minute);
    final difference = selectedDateTime.difference(DateTime.now());

    String dayLabel;
    if (difference.inDays == 0) {
      dayLabel = "Today";
    } else if (difference.inDays == 1) {
      dayLabel = "Tomorrow";
    } else {
      dayLabel = DateFormat('MMM d').format(selectedDateTime);
    }

    return Container(
      width: 130,
      decoration: BoxDecoration(
        color: AdaptiveTheme.of(context).mode.isDark ? Colors.grey[700] : const Color(0xf2ffffff),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(3, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
              color: const Color.fromRGBO(167, 153, 240, 1),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              formattedTime,
              style: TextStyle(
                color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 2,
              width: 60,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 8),
            Text(
              dayLabel,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeDifference(BuildContext context) {
    final startTime = DateTime(2021, 1, 1, _startTime.hour, _startTime.minute);
    final endTime = DateTime(2021, 1, 1, _endTime.hour, _endTime.minute);
    final difference = endTime.difference(startTime);

    int totalMinutes = difference.inMinutes;

    int hours = totalMinutes ~/ 60; // Divide by 60 to get hours
    int minutes = totalMinutes % 60; // Remainder is minutes

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            text: '$hours hours',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              if (minutes > 0) // Show minutes only if they are greater than 0
                TextSpan(
                  text: ' $minutes minutes',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
        // Text(
        //   "  $hours hours $minutes minutes",
        //   style: TextStyle(
        //     fontSize: 23,
        //     fontWeight: FontWeight.bold,
        //     color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
        //   ),
        // ),
      ],
    );
  }
}
