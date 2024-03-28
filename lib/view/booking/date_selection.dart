// import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:calendar_date_picker2/calendar_date_picker2.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:smart_parking_system/res/common/app_button/main_button.dart';
// import 'package:smart_parking_system/view/booking/time_selection.dart';
//
// class DateSelectionPage extends StatefulWidget {
//   const DateSelectionPage({Key? key}) : super(key: key);
//
//   @override
//   State<DateSelectionPage> createState() => _DateSelectionPageState();
// }
//
// class _DateSelectionPageState extends State<DateSelectionPage> {
//   List<DateTime?> _singleDatePickerValueWithDefaultValue = [
//     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
//       appBar: AppBar(
//         backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
//         title: const Text(
//           'Select Date',
//           style: TextStyle(
//             fontFamily: "Lato",
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(18.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 10),
//                 _buildDefaultSingleDatePickerWithValue(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDefaultSingleDatePickerWithValue() {
//     final config = CalendarDatePicker2Config(
//       selectedDayHighlightColor: Color(0xffc4cdfa),
//       weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
//       weekdayLabelTextStyle: TextStyle(
//         color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Color(0xff001128),
//         fontWeight: FontWeight.bold,
//       ),
//       firstDayOfWeek: 1,
//       controlsHeight: 50,
//       controlsTextStyle: TextStyle(
//         color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
//         fontSize: 15,
//         fontWeight: FontWeight.bold,
//       ),
//       dayTextStyle: TextStyle(
//         color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Color(0xff001128),
//         fontWeight: FontWeight.bold,
//       ),
//       disabledDayTextStyle: const TextStyle(
//         color: Colors.grey,
//       ),
//       selectableDayPredicate: (day) {
//         final today = DateTime.now();
//         final tomorrow = today.add(Duration(days: 1));
//
//         // Allow selection if the day is today or tomorrow
//         return day.year == today.year && day.month == today.month && (day.day == today.day || day.day == tomorrow.day);
//       },
//     );
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 10),
//         CalendarDatePicker2(
//           config: config,
//           value: _singleDatePickerValueWithDefaultValue,
//           onValueChanged: (dates) => setState(() => _singleDatePickerValueWithDefaultValue = dates),
//         ),
//         Row(
//           children: [
//             Text(
//               'Selected Date  : ',
//               style: TextStyle(
//                 color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Color(0xff001128),
//                 fontSize: 22,
//                 fontWeight: FontWeight.w800,
//               ),
//             ),
//             Text(
//               DateFormat(' MMM d, yyyy').format(_singleDatePickerValueWithDefaultValue.first!),
//               style: const TextStyle(fontSize: 20),
//             ),
//           ],
//         ),
//         SizedBox(height: 130),
//         Center(
//           child: SizedBox(
//             width: double.infinity,
//             child: MainButton(
//               mainOnPress: () {
//                 // Navigate to the next page for selecting start and end time
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => TimeSelectionPage(selectedDate: _singleDatePickerValueWithDefaultValue.first!)),
//                 );
//               },
//               textName: "Next",
//               fontSize: 17,
//               textColor: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Color(0xff001128),
//               backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.grey[800] : const Color(0xffe4ebff),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_parking_system/res/common/app_button/main_button.dart';
import 'package:smart_parking_system/view/booking/time_selection.dart';

class DateSelectionPage extends StatefulWidget {
  const DateSelectionPage({Key? key}) : super(key: key);

  @override
  State<DateSelectionPage> createState() => _DateSelectionPageState();
}

class _DateSelectionPageState extends State<DateSelectionPage> {
  List<DateTime?> _singleDatePickerValueWithDefaultValue = [
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
  ];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
      appBar: AppBar(
        backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
        title: const Text('Select Date'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildDefaultSingleDatePickerWithValue(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultSingleDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      selectedDayHighlightColor: const Color(0xffc4cdfa),
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 1,
      controlsHeight: 50,
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      selectableDayPredicate: (day) {
        final today = DateTime.now();
        final tomorrow = today.add(const Duration(days: 1));

        // Allow selection if the day is today or tomorrow
        return day.year == today.year && day.month == today.month && (day.day == today.day || day.day == tomorrow.day);
      },
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        CalendarDatePicker2(
          config: config,
          value: _singleDatePickerValueWithDefaultValue,
          onValueChanged: (dates) => setState(() => _singleDatePickerValueWithDefaultValue = dates),
        ),
        Row(
          children: [
            const Text(
              'Selected Date  : ',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              DateFormat(' MMM d, yyyy').format(_singleDatePickerValueWithDefaultValue.first!),
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        const SizedBox(height: 130),
        Center(
          child: SizedBox(
            width: double.infinity,
            child: MainButton(
              mainOnPress: () {
                saveSelectedDateToFirebase(_singleDatePickerValueWithDefaultValue.first!);
              },
              textName: "Next",
              fontSize: 17,
              textColor: AdaptiveTheme.of(context).mode.isDark ? Colors.white : const Color(0xff001128),
              backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.grey[800] : const Color(0xffe4ebff),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> saveSelectedDateToFirebase(DateTime selectedDate) async {
    try {
      // Get current user
      User? user = _auth.currentUser;

      if (user != null) {
        // Create a reference to the user's document in 'bookings' collection
        DocumentReference userBookingRef = _firestore.collection('bookings').doc(user.uid);

        // Create a map with the selected date
        Map<String, dynamic> bookingData = {
          'selectedDate': Timestamp.fromDate(selectedDate),
        };

        // Set the document with the booking data
        await userBookingRef.set(bookingData);
        debugPrint("date : {$selectedDate}");
        // Navigate to the next page for selecting start and end time
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TimeSelectionPage(selectedDate: selectedDate)),
        );
      }
    } catch (e) {
      debugPrint('Error saving date to Firestore: $e');
    }
  }
}
