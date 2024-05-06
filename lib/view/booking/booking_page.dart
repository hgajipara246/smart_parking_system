// import 'dart:math' as math;
//
// import 'package:adaptive_theme/adaptive_theme.dart';
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

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_parking_system/view/booking/date_selection.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final ref = FirebaseDatabase.instance.ref("sensor_data/sensor_occupacy");
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Map<String, dynamic>? _data;

  @override
  Widget build(BuildContext context) {
    double hieght = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
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
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 80,
                  childAspectRatio: 1.3,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 38.0),
                    child: _buildCombinedContainer(
                      context,
                      index,
                      onTap: () {
                        debugPrint('Slot ${index + 1} clicked');
                        _navigateToDateSelection(index + 1);
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
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

  Widget _buildCombinedContainer(BuildContext context, int index, {Function()? onTap}) {
    return GestureDetector(
      onTap: () {
        // Only perform onTap action if the slot is available (not occupied)
        if (!_isSlotOccupied(index + 1)) {
          onTap?.call();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AdaptiveTheme.of(context).mode.isDark ? Colors.grey : Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SensorValueWidget(
              databaseReference: ref.child('slot${index + 1}'),
            ),
            SizedBox(width: 10),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                'Slot ${index + 1}',
                style: TextStyle(
                  fontFamily: "Lato",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Function to check if a slot is occupied
  bool _isSlotOccupied(int slotNumber) {
    // Check if data is available and if the sensor value is not 0 (occupied)
    return _data != null && _data!['slot$slotNumber'] != 0;
  }

  void _navigateToDateSelection(int slotNumber) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DateSelectionPage(slotNumber: slotNumber),
      ),
    );
  }
}

class SensorValueWidget extends StatelessWidget {
  final DatabaseReference databaseReference;

  const SensorValueWidget({
    required this.databaseReference,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
      stream: databaseReference.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
          int sensorValue = snapshot.data!.snapshot.value as int;
          bool isOccupied = sensorValue != 0;
          debugPrint("----------->>>$sensorValue");

          if (isOccupied) {
            return Image.asset(
              'assets/images/carLIGHTbLUE.png',
              height: 40,
              fit: BoxFit.cover,
            );
          } else {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.done,
                  color: Colors.green,
                ),
                Text("Available", style: TextStyle(fontSize: 12)),
              ],
            );
          }
        }

        return const Text('No data available');
      },
    );
  }
}

// import 'dart:convert';
// import 'dart:math' as math;
//
// import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
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
//   bool _isDeviceOn = false;
//   final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child('device_control');
//
//   void _updateDeviceStatus(bool isOn) {
//     String status = isOn ? 'on' : 'off';
//     _databaseReference.set(status);
//   }
//
//   Map<String, dynamic>? _data;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   Future<void> fetchData() async {
//     var url = "https://automate-park-42481-default-rtdb.asia-southeast1.firebasedatabase.app/sensor_data/sensor_occupacy.json";
//
//     http.get(Uri.parse(url)).then((response) {
//       if (response.statusCode == 200) {
//         setState(() {
//           _data = json.decode(response.body);
//         });
//       } else {
//         print("Error fetching data. Status code: ${response.statusCode}");
//       }
//     }).catchError((error) {
//       print("Error fetching data: $error");
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double hieght = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.height;
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
//                 itemCount: 4,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 80,
//                   childAspectRatio: 1.3,
//                   mainAxisSpacing: 2,
//                 ),
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: EdgeInsets.only(top: 38.0),
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
//               Padding(
//                 padding: const EdgeInsets.only(left: 15),
//                 child: Row(
//                   children: [
//                     Container(
//                       height: hieght / 9,
//                       width: width / 15,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.black,
//                         ),
//                         borderRadius: BorderRadius.circular(hieght / 80),
//                       ),
//                       child: SensorValueWidget(
//                         databaseReference: ref.child('slot1'),
//                       ),
//                     ),
//                     SizedBox(width: width / 60),
//                     Container(
//                       height: hieght / 9,
//                       width: width / 15,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.black,
//                         ),
//                         borderRadius: BorderRadius.circular(hieght / 80),
//                       ),
//                       child: SensorValueWidget(
//                         databaseReference: ref.child('slot2'),
//                       ),
//                     ),
//                     SizedBox(width: width / 60),
//                     Container(
//                       height: hieght / 9,
//                       width: width / 15,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.black,
//                         ),
//                         borderRadius: BorderRadius.circular(hieght / 80),
//                       ),
//                       child: SensorValueWidget(
//                         databaseReference: ref.child('slot3'),
//                       ),
//                     ),
//                     SizedBox(width: width / 60),
//                     Container(
//                       height: hieght / 9,
//                       width: width / 15,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.black,
//                         ),
//                         borderRadius: BorderRadius.circular(hieght / 80),
//                       ),
//                       child: SensorValueWidget(
//                         databaseReference: ref.child('slot4'),
//                       ),
//                     ),
//                   ],
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
//               'assets/images/blueCar.png',
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
//         return const Text('No data available');
//       },
//     );
//   }
// }
// -------------------------------------------------------------------------------------
//
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
//
// class PickParkingSlot extends StatefulWidget {
//   const PickParkingSlot({Key? key, required String receivedData}) : super(key: key);
//
//   @override
//   State<PickParkingSlot> createState() => _PickParkingSlotState();
// }
//
// class _PickParkingSlotState extends State<PickParkingSlot> {
//   final ref = FirebaseDatabase.instance.ref("sensor_data/sensor_occupacy");
//   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//
//   bool _isDeviceOn = false;
//   final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child('device_control');
//
//   void _updateDeviceStatus(bool isOn) {
//     String status = isOn ? 'on' : 'off';
//     _databaseReference.set(status);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double hieght = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       drawer: const Drawer(),
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.black),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Pick Parking Slot',
//           style: TextStyle(
//             color: Color(0xFF212121),
//             fontSize: 24,
//             fontFamily: 'Urbanist',
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const Text(
//                 "Temprature",
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               SizedBox(height: hieght / 10),
//               const Divider(color: Colors.black, endIndent: 15, indent: 15),
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: hieght / 35),
//                 child: Row(
//                   children: [
//                     const Expanded(child: Divider(color: Colors.black, endIndent: 15, indent: 15)),
//                     SizedBox(width: width / 25),
//                     const Expanded(child: Divider(color: Colors.black, endIndent: 15, indent: 15)),
//                     SizedBox(width: width / 25),
//                     const Expanded(child: Divider(color: Colors.black, endIndent: 15, indent: 15)),
//                     SizedBox(width: width / 25),
//                     const Expanded(child: Divider(color: Colors.black, endIndent: 15, indent: 15)),
//                     SizedBox(width: width / 25),
//                     const Expanded(child: Divider(color: Colors.black, endIndent: 15, indent: 15)),
//                   ],
//                 ),
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Divider(color: Colors.black, endIndent: 70, indent: 15),
//                 ],
//               ),
//               Row(
//                 children: [
//                   const Expanded(child: Divider(color: Colors.black, endIndent: 50, indent: 15)),
//                   SizedBox(width: width / 25),
//                 ],
//               ),
//               SizedBox(height: hieght / 90),
//               Padding(
//                 padding: const EdgeInsets.only(left: 15),
//                 child: Row(
//                   children: [
//                     Container(
//                       height: hieght / 9,
//                       width: width / 15,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.black,
//                         ),
//                         borderRadius: BorderRadius.circular(hieght / 80),
//                       ),
//                       child: SensorValueWidget(
//                         databaseReference: ref.child('slot1'),
//                       ),
//                     ),
//                     SizedBox(width: width / 60),
//                     Container(
//                       height: hieght / 9,
//                       width: width / 15,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.black,
//                         ),
//                         borderRadius: BorderRadius.circular(hieght / 80),
//                       ),
//                       child: SensorValueWidget(
//                         databaseReference: ref.child('slot2'),
//                       ),
//                     ),
//                     SizedBox(width: width / 60),
//                     Container(
//                       height: hieght / 9,
//                       width: width / 15,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.black,
//                         ),
//                         borderRadius: BorderRadius.circular(hieght / 80),
//                       ),
//                       child: SensorValueWidget(
//                         databaseReference: ref.child('slot3'),
//                       ),
//                     ),
//                     SizedBox(width: width / 60),
//                     Container(
//                       height: hieght / 9,
//                       width: width / 15,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.black,
//                         ),
//                         borderRadius: BorderRadius.circular(hieght / 80),
//                       ),
//                       child: SensorValueWidget(
//                         databaseReference: ref.child('slot4'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: hieght / 10,
//               ),
//               const Divider(color: Colors.black, endIndent: 15, indent: 80),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Exit barrier"),
//                   Switch(
//                     activeColor: const Color(0x6F1988BB),
//                     value: _isDeviceOn,
//                     onChanged: (value) {
//                       setState(() {
//                         _isDeviceOn = value;
//                       });
//                       _updateDeviceStatus(value);
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(height: hieght / 10),
//             ],
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
//               'assets/images/blueCar.png',
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
//         return const Text('No data available');
//       },
//     );
//   }
// }
