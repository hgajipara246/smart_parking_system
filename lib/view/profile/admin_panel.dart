import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_parking_system/model/parking_model.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  FirebaseFirestore? firebaseFirestore;
  bool isLoading = true;

  int bookingsToday = 0;
  int bookingsThisWeek = 0;
  int totalBookingHours = 0;
  int bookingsCurrentMonth = 0;
  int bookingsAdvanceCurrentDate = 0;
  int maxBillThisMonth = 0;

  @override
  void initState() {
    super.initState();
    firebaseFirestore = FirebaseFirestore.instance;
    fetchBookingData();
  }

  Future<void> fetchBookingData() async {
    try {
      // Fetch data from Firestore
      QuerySnapshot snapshot = await firebaseFirestore!.collection("paymentsDetails").get();
      List<PaymentModel> bookings = snapshot.docs.map((doc) => PaymentModel.fromSnapshot(doc)).toList();

      DateTime now = DateTime.now();
      DateTime startOfToday = DateTime(now.year, now.month, now.day);
      DateTime startOfWeek = startOfToday.subtract(Duration(days: now.weekday - 1));
      DateTime startOfMonth = DateTime(now.year, now.month, 1);
      DateTime endOfMonth = DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));

      int todayCount = 0;
      int weekCount = 0;
      int monthCount = 0;
      int hoursCount = 0;
      int advanceTodayCount = 0;
      int maxBill = 0;

      for (var booking in bookings) {
        DateTime bookingDate;

        // Try parsing the date in the format 'MMM dd, yyyy'
        try {
          bookingDate = DateFormat('MMM dd, yyyy').parse(booking.selectedDate);
          print("Parsed date: $bookingDate");
        } catch (e) {
          print("Error parsing date: ${booking.selectedDate} - $e");
          continue;
        }

        // Compare only the date part
        if (bookingDate.isAtSameMomentAs(startOfToday)) {
          todayCount++;
        }

        if (bookingDate.isAfter(startOfWeek) || bookingDate.isAtSameMomentAs(startOfWeek)) {
          weekCount++;
        }

        if (bookingDate.isAfter(startOfMonth.subtract(const Duration(days: 1))) && bookingDate.isBefore(endOfMonth.add(const Duration(days: 1)))) {
          monthCount++;
          if (booking.total > maxBill) {
            maxBill = booking.total;
          }
        }

        // Count bookings in advance for current date
        if (bookingDate.isAfter(startOfToday)) {
          advanceTodayCount++;
        }

        // Parse booking times
        try {
          int startHour = int.parse(booking.startTime.split(":")[0]);
          int endHour = int.parse(booking.endTime.split(":")[0]);
          hoursCount += (endHour - startHour);
        } catch (e) {
          print("Error parsing times: ${booking.startTime} - ${booking.endTime} - $e");
          continue;
        }
      }

      setState(() {
        bookingsToday = todayCount;
        bookingsThisWeek = weekCount;
        bookingsCurrentMonth = monthCount;
        bookingsAdvanceCurrentDate = advanceTodayCount;
        totalBookingHours = hoursCount;
        maxBillThisMonth = maxBill;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching booking data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _handleRefresh() async {
    setState(() {
      isLoading = true;
    });
    await fetchBookingData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
      appBar: AppBar(
        title: const Text("Admin Panel"),
        backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // Ensures RefreshIndicator works when child is smaller than screen
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Booking Statistics",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.headlineMedium!.color,
                      ),
                    ),
                    const SizedBox(height: 16),
                    buildStatCard("Bookings Today", bookingsToday),
                    buildStatCard("Bookings This Week", bookingsThisWeek),
                    buildStatCard("Bookings This Month", bookingsCurrentMonth),
                    buildStatCard("Advance Bookings for Today", bookingsAdvanceCurrentDate),
                    buildStatCard("Maximum Bill This Month", maxBillThisMonth),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildStatCard(String title, int value) {
    return Card(
      borderOnForeground: true,
      semanticContainer: false,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AdaptiveTheme.of(context).mode.isDark ? Colors.green : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
