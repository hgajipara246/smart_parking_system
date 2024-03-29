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
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GridView.count(
                shrinkWrap: true,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,

                childAspectRatio: 1.5,
                crossAxisCount: 2, // 3 columns in one row
                children: [
                  _buildClickableContainer(
                    color: Colors.blue,
                    text: 'Slot 1',
                    onTap: () {
                      print('Slot 1 clicked');
                    },
                    slotNumber: 1,
                  ),
                  _buildClickableContainer(
                    color: Colors.green,
                    text: 'Slot 2',
                    onTap: () {
                      print('Slot 2 clicked');
                    },
                    slotNumber: 2,
                  ),
                  _buildClickableContainer(
                    color: Colors.green,
                    text: 'Slot 3',
                    onTap: () {
                      print('Slot 3 clicked');
                    },
                    slotNumber: 3,
                  ),
                  _buildClickableContainer(
                    color: Colors.blue,
                    text: 'Slot 4',
                    onTap: () {
                      print('Slot 4 clicked');
                    },
                    slotNumber: 4,
                  ),
                  _buildClickableContainer(
                    color: Colors.blue,
                    text: 'Slot 5',
                    onTap: () {
                      print('Slot 5 clicked');
                    },
                    slotNumber: 5,
                  ),
                  _buildClickableContainer(
                    color: Colors.green,
                    text: 'Slot 6',
                    onTap: () {
                      print('Slot 6 clicked');
                    },
                    slotNumber: 6,
                  ),
                ],
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

  Widget _buildClickableContainer({
    required Color color,
    required String text,
    required int slotNumber,
    required void Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: () {
          _navigateToDateSelection(slotNumber);
          print('Slot $slotNumber clicked');
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: color,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
