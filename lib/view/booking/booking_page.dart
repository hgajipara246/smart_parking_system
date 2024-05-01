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

import 'dart:convert';
import 'dart:math' as math;

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smart_parking_system/view/booking/date_selection.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  Map<String, dynamic>? _data;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var url = "https://automate-park-42481-default-rtdb.asia-southeast1.firebasedatabase.app/sensor_data/sensor_occupacy.json";

    http.get(Uri.parse(url)).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          _data = json.decode(response.body);
        });
      } else {
        print("Error fetching data. Status code: ${response.statusCode}");
      }
    }).catchError((error) {
      print("Error fetching data: $error");
    });
  }

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
              Center(
                child: _data == null
                    ? CircularProgressIndicator()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Data from Firebase:"),
                          SizedBox(height: 20),
                          Text("Slot 1: ${_data!['slot1']}"),
                          Text("Slot 2: ${_data!['slot2']}"),
                          Text("Slot 3: ${_data!['slot3']}"),
                          Text("Slot 4: ${_data!['slot4']}"),
                        ],
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
