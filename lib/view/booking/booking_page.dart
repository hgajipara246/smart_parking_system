
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
