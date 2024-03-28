// // *********----------------///////////////////+++++++++++++++++++++++++++--------------------------------*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/
// //
// // import 'package:adaptive_theme/adaptive_theme.dart';
// // import 'package:day_night_time_picker/day_night_time_picker.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:smart_parking_system/res/common/app_button/main_button.dart';
// //
// // class BookingPage extends StatefulWidget {
// //   const BookingPage({super.key});
// //
// //   @override
// //   State<BookingPage> createState() => _BookingPageState();
// // }
// //
// // class _BookingPageState extends State<BookingPage> {
// //   Time _time = Time(hour: 11, minute: 30, second: 20);
// //   bool iosStyle = true;
// //   Time _startTime = Time(hour: 10, minute: 0); // Default start time
// //   Time _endTime = Time(hour: 10, minute: 0); // Default end time
// //
// //   void onTimeChanged(Time newTime) {
// //     setState(() {
// //       _time = newTime;
// //     });
// //   }
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
// //       appBar: AppBar(
// //         backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
// //         title: const Text(
// //           'Book Slot',
// //           style: TextStyle(
// //             fontFamily: "Lato",
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ),
// //       body: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.all(18.0),
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.start,
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 "Select Time",
// //                 style: TextStyle(
// //                   fontSize: 20,
// //                   fontFamily: "Lato",
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(8.0),
// //                 child: Container(
// //                   child: Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                     children: [
// //                       MainButton(
// //                         textName: "Start Time",
// //                         textColor: Colors.black,
// //                         mainOnPress: () {
// //                           Navigator.of(context).push(
// //                             showPicker(
// //                               context: context,
// //                               value: _startTime,
// //                               sunrise: TimeOfDay(hour: 6, minute: 0),
// //                               sunset: TimeOfDay(hour: 18, minute: 0),
// //                               duskSpanInMinutes: 120,
// //                               onChange: (selectedTime) {
// //                                 setState(() {
// //                                   _startTime = selectedTime;
// //                                 });
// //                               },
// //                             ),
// //                           );
// //                         },
// //                         backgroundColor: Color.fromRGBO(241, 248, 255, 1),
// //                       ),
// //                       MainButton(
// //                         textName: "End Time",
// //                         textColor: Colors.black,
// //                         mainOnPress: () {
// //                           Navigator.of(context).push(
// //                             showPicker(
// //                               context: context,
// //                               value: _endTime,
// //                               sunrise: TimeOfDay(hour: 6, minute: 0),
// //                               sunset: TimeOfDay(hour: 18, minute: 0),
// //                               duskSpanInMinutes: 120,
// //                               onChange: (selectedTime) {
// //                                 setState(() {
// //                                   _endTime = selectedTime;
// //                                 });
// //                               },
// //                             ),
// //                           );
// //                         },
// //                         backgroundColor: Color.fromRGBO(241, 248, 255, 1),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                 children: [
// //                   Container(
// //                     height: 190,
// //                     width: 140,
// //                     decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       boxShadow: [BoxShadow(color: Colors.black12)],
// //                       borderRadius: BorderRadius.circular(20),
// //                     ),
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Icon(
// //                             CupertinoIcons.car_detailed,
// //                             size: 60,
// //                             color: Color.fromRGBO(167, 153, 240, 1),
// //                           ),
// //                           SizedBox(
// //                             width: 90,
// //                             child: FittedBox(
// //                               fit: BoxFit.fitWidth,
// //                               child: Text(
// //                                 "start time",
// //                                 style: TextStyle(
// //                                   color: Color.fromRGBO(54, 61, 86, 1),
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                           SizedBox(height: 7),
// //                           SizedBox(
// //                             width: 110,
// //                             child: FittedBox(
// //                               fit: BoxFit.fitWidth,
// //                               child: Text(
// //                                 "${_startTime.format(context)}", // Display selected start time
// //                                 style: TextStyle(
// //                                   color: Color.fromRGBO(54, 61, 86, 1),
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                           SizedBox(height: 3),
// //                           SizedBox(
// //                             width: 70,
// //                             child: const FittedBox(
// //                               fit: BoxFit.fitWidth,
// //                               child: Text(
// //                                 "Tomorrow",
// //                                 style: TextStyle(
// //                                   color: Color.fromRGBO(144, 158, 174, 1),
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                   Container(
// //                     height: 190,
// //                     width: 140,
// //                     decoration: BoxDecoration(
// //                       color: Colors.white,
// //                       boxShadow: [BoxShadow(color: Colors.black12)],
// //                       borderRadius: BorderRadius.circular(20),
// //                     ),
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Icon(
// //                             Icons.local_parking_rounded,
// //                             size: 60,
// //                             color: Color.fromRGBO(167, 153, 240, 1),
// //                           ),
// //                           SizedBox(
// //                             width: 90,
// //                             child: FittedBox(
// //                               fit: BoxFit.fitWidth,
// //                               child: Text(
// //                                 "end time",
// //                                 style: TextStyle(
// //                                   color: Color.fromRGBO(54, 61, 86, 1),
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                           SizedBox(height: 7),
// //                           SizedBox(
// //                             width: 110,
// //                             child: FittedBox(
// //                               fit: BoxFit.fitWidth,
// //                               child: Text(
// //                                 "${_endTime.format(context)}", // Display selected start time
// //                                 style: TextStyle(
// //                                   color: Color.fromRGBO(54, 61, 86, 1),
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                           SizedBox(height: 3),
// //                           SizedBox(
// //                             width: 70,
// //                             child: const FittedBox(
// //                               fit: BoxFit.fitWidth,
// //                               child: Text(
// //                                 "Tomorrow",
// //                                 style: TextStyle(
// //                                   color: Color.fromRGBO(144, 158, 174, 1),
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:calendar_date_picker2/calendar_date_picker2.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class BookingPage extends StatefulWidget {
//   const BookingPage({Key? key}) : super(key: key);
//
//   @override
//   State<BookingPage> createState() => _BookingPageState();
// }
//
// class _BookingPageState extends State<BookingPage> {
//   List<DateTime?> _singleDatePickerValueWithDefaultValue = [
//     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
//   ];
//
//   TimeOfDay _startTime = TimeOfDay(hour: 10, minute: 0); // Default start time
//   TimeOfDay _endTime = TimeOfDay(hour: 10, minute: 0); // Default end time
//
//   void _selectStartTime(BuildContext context) async {
//     final TimeOfDay? newTime = await showTimePicker(
//       context: context,
//       initialTime: _startTime,
//     );
//     if (newTime != null) {
//       setState(() {
//         _startTime = newTime;
//       });
//     }
//   }
//
//   void _selectEndTime(BuildContext context) async {
//     final TimeOfDay? newTime = await showTimePicker(
//       context: context,
//       initialTime: _endTime,
//     );
//     if (newTime != null) {
//       setState(() {
//         _endTime = newTime;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
//       appBar: AppBar(
//         backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
//         title: const Text(
//           'Book Slot',
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
//                 Text(
//                   "Select Date",
//                   style: TextStyle(
//                     fontSize: 25,
//                     fontFamily: "Lato",
//                     fontWeight: FontWeight.bold,
//                     color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
//                   ),
//                 ),
//                 _buildDefaultSingleDatePickerWithValue(),
//                 Text(
//                   "Select Time",
//                   style: TextStyle(
//                     fontSize: 25,
//                     fontFamily: "Lato",
//                     fontWeight: FontWeight.bold,
//                     color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     _buildTimeButton("Start Time", _startTime, _selectStartTime),
//                     _buildTimeButton("End Time", _endTime, _selectEndTime),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     _buildTimeDisplay("Start Time", _startTime),
//                     _buildTimeDisplay("End Time", _endTime),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 _buildTimeDifference(),
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
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 15),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Selected Date  : ',
//                 style: TextStyle(
//                   color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Color(0xff001128),
//                   fontSize: 22,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//               Text(
//                 _singleDatePickerValueWithDefaultValue.toString(),
//                 style: const TextStyle(fontSize: 15),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 25),
//       ],
//     );
//   }
//
//   Widget _buildTimeButton(String title, TimeOfDay time, void Function(BuildContext) onPressed) {
//     return ElevatedButton(
//       onPressed: () => onPressed(context),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.grey[800] : const Color.fromRGBO(241, 248, 255, 1),
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(
//             Icons.access_time,
//             color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
//           ),
//           SizedBox(width: 8),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTimeDisplay(String title, TimeOfDay time) {
//     final formattedTime = DateFormat('h:mm a').format(DateTime(2021, 1, 1, time.hour, time.minute));
//
//     late IconData icon;
//
//     if (title == "Start Time") {
//       icon = CupertinoIcons.car_detailed;
//     } else if (title == "End Time") {
//       icon = Icons.local_parking_rounded;
//     }
//
//     return Container(
//       height: 190,
//       width: 140,
//       decoration: BoxDecoration(
//         color: AdaptiveTheme.of(context).mode.isDark ? Colors.grey[900] : Colors.white,
//         boxShadow: [BoxShadow(color: Colors.black12)],
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(
//               icon,
//               size: 60,
//               color: Color.fromRGBO(167, 153, 240, 1),
//             ),
//             SizedBox(
//               width: 80,
//               child: FittedBox(
//                 fit: BoxFit.fitWidth,
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                     color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             SizedBox(
//               width: 100,
//               child: FittedBox(
//                 fit: BoxFit.fitWidth,
//                 child: Text(
//                   formattedTime,
//                   style: TextStyle(
//                     color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 3),
//             SizedBox(
//               width: 65,
//               child: const FittedBox(
//                 fit: BoxFit.fitWidth,
//                 child: Text(
//                   "Tomorrow",
//                   style: TextStyle(
//                     color: Color.fromRGBO(144, 158, 174, 1),
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTimeDifference() {
//     final startTime = DateTime(2021, 1, 1, _startTime.hour, _startTime.minute);
//     final endTime = DateTime(2021, 1, 1, _endTime.hour, _endTime.minute);
//     final difference = endTime.difference(startTime).inHours;
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "Duration: $difference hours",
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
