import 'dart:math' as math;

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:smart_parking_system/view/booking/date_selection.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
      appBar: AppBar(
        backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
        title: const Text(
          'Booking',
          style: TextStyle(
            fontFamily: "Lato",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 80,
                  childAspectRatio: 1.3,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 38.0),
                    child: _buildRotatedClickableContainer(
                      // color: index.isEven ? Colors.blue : Colors.green,
                      color: AdaptiveTheme.of(context).mode.isDark ? Colors.grey : Colors.white,
                      text: 'Slot ${index + 1}',

                      onTap: () {
                        debugPrint('Slot ${index + 1} clicked');
                        _navigateToDateSelection(index + 1);
                      },
                      slotNumber: index + 1,
                      isLeftColumn: index.isEven, txtColor: Colors.black, // Determine if it's the left column
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Opacity(
                  opacity: 0.4,
                  child: Image.asset(
                    "assets/images/upside.png",
                    height: 80,
                  ),
                ),
              ),
              const Text(
                textAlign: TextAlign.center,
                "Entry",
                style: TextStyle(
                  fontFamily: "Lato",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 55.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info,
                        size: 20,
                        color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        textAlign: TextAlign.center,
                        "Please select an available parking slot & make \nyour reservation.",
                        style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToDateSelection(int slotNumber) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DateSelectionPage(slotNumber: slotNumber),
      ),
    );
  }

  Widget _buildRotatedClickableContainer({
    required Color color,
    required String text,
    required Color txtColor,
    required int slotNumber,
    required void Function() onTap,
    required bool isLeftColumn,
  }) {
    double rotationAngle = isLeftColumn ? -0 : 0; // Rotate left column -40 degrees, right column 40 degrees
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: onTap,
        child: Transform.rotate(
          angle: rotationAngle * math.pi / 130, // Convert degrees to radians
          child: Container(
            decoration: BoxDecoration(
              color: color,
              boxShadow: [
                BoxShadow(
                  color: AdaptiveTheme.of(context).mode.isDark ? Colors.grey.shade600 : Colors.grey.shade300,
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Transform.rotate(
                  angle: 0 * 3.14 / 180,
                  child: Image.asset(
                    "assets/images/carLIGHTbLUE.png",
                    height: 100,
                  ),
                ),
                // Text(
                //   text,
                //   style: TextStyle(color: txtColor, fontSize: 20),
                // ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// options: FirebaseOptions(
// apiKey: "<AIzaSyDpfc443lJiH62YOlePgOLGj44Hom44Ek8>",
// appId: "1:669445423505:android:873dade159f55a26cc9a30",
// messagingSenderId: "669445423505",
// projectId: "automate-park-42481",
// databaseURL: "https://automate-park-42481-default-rtdb.asia-southeast1.firebasedatabase.app/",
// ),
//
// import 'dart:math' as math;
//
// import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:smart_parking_system/view/booking/date_selection.dart';
//
// class BookingPage extends StatefulWidget {
//   const BookingPage({Key? key}) : super(key: key);
//
//   @override
//   State<BookingPage> createState() => _BookingPageState();
// }
//
// class _BookingPageState extends State<BookingPage> {
//   final ref = FirebaseDatabase.instance.ref("sensor_data/sensor_occupacy");
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
//       appBar: AppBar(
//         backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
//         title: const Text(
//           'Booking',
//           style: TextStyle(
//             fontFamily: "Lato",
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: 6,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 80,
//                   childAspectRatio: 1.3,
//                   mainAxisSpacing: 2,
//                 ),
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(top: 38.0),
//                     child: _buildRotatedClickableContainer(
//                       // color: index.isEven ? Colors.blue : Colors.green,
//                       color: AdaptiveTheme.of(context).mode.isDark ? Colors.grey : Colors.white,
//                       text: 'Slot ${index + 1}',
//
//                       onTap: () {
//                         debugPrint('Slot ${index + 1} clicked');
//                         _navigateToDateSelection(index + 1);
//                       },
//                       slotNumber: index + 1,
//                       isLeftColumn: index.isEven, txtColor: Colors.black, // Determine if it's the left column
//                     ),
//                   );
//                 },
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15),
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 60,
//                       width: 200,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.black,
//                         ),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: SensorValueWidget(
//                         databaseReference: ref.child('slot1'),
//                       ),
//                     ),
//                     Container(
//                       height: 60,
//                       width: 200,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.black,
//                         ),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: SensorValueWidget(
//                         databaseReference: ref.child('slot2'),
//                       ),
//                     ),
//                     Container(
//                       height: 60,
//                       width: 200,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.black,
//                         ),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: SensorValueWidget(
//                         databaseReference: ref.child('slot3'),
//                       ),
//                     ),
//                     Container(
//                       height: 60,
//                       width: 200,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.black,
//                         ),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: SensorValueWidget(
//                         databaseReference: ref.child('slot4'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 18.0),
//                 child: Opacity(
//                   opacity: 0.4,
//                   child: Image.asset(
//                     "assets/images/upside.png",
//                     height: 80,
//                   ),
//                 ),
//               ),
//               const Text(
//                 textAlign: TextAlign.center,
//                 "Entry",
//                 style: TextStyle(
//                   fontFamily: "Lato",
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 55.0),
//                 child: Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Icon(
//                         Icons.info,
//                         size: 20,
//                         color: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
//                       ),
//                       const SizedBox(width: 5),
//                       const Text(
//                         textAlign: TextAlign.center,
//                         "Please select an available parking slot & make \nyour reservation.",
//                         style: TextStyle(
//                           fontFamily: "Lato",
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _navigateToDateSelection(int slotNumber) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => DateSelectionPage(slotNumber: slotNumber),
//       ),
//     );
//   }
//
//   Widget _buildRotatedClickableContainer({
//     required Color color,
//     required String text,
//     required Color txtColor,
//     required int slotNumber,
//     required void Function() onTap,
//     required bool isLeftColumn,
//   }) {
//     double rotationAngle = isLeftColumn ? -0 : 0; // Rotate left column -40 degrees, right column 40 degrees
//     return Padding(
//       padding: const EdgeInsets.all(3.0),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Transform.rotate(
//           angle: rotationAngle * math.pi / 130, // Convert degrees to radians
//           child: Container(
//             decoration: BoxDecoration(
//               color: color,
//               boxShadow: [
//                 BoxShadow(
//                   color: AdaptiveTheme.of(context).mode.isDark ? Colors.grey.shade600 : Colors.grey.shade300,
//                   blurRadius: 5,
//                   spreadRadius: 1,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Center(
//                 child: Transform.rotate(
//                   angle: 0 * 3.14 / 180,
//                   child: Image.asset(
//                     "assets/images/carLIGHTbLUE.png",
//                     height: 100,
//                   ),
//                 ),
//                 // Text(
//                 //   text,
//                 //   style: TextStyle(color: txtColor, fontSize: 20),
//                 // ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class SensorValueWidget extends StatelessWidget {
//   final DatabaseReference databaseReference;
//
//   const SensorValueWidget({
//     required this.databaseReference,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<DatabaseEvent>(
//       stream: databaseReference.onValue,
//       builder: (context, snapshot) {
//         if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
//           int sensorValue = snapshot.data!.snapshot.value as int;
//           bool isOccupied = sensorValue != 0;
//           debugPrint("----------->>>$sensorValue");
//
//           if (isOccupied) {
//             return Image.asset(
//               'assets/images/cars.png',
//               height: 10,
//               fit: BoxFit.cover,
//             );
//           } else {
//             return const Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.done,
//                   color: Colors.green,
//                 ),
//                 Text("Available", style: TextStyle(fontSize: 12)),
//               ],
//             );
//           }
//         }
//
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: const Text('No data available'),
//         );
//       },
//     );
//   }
// }
