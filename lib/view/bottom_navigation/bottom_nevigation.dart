import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smart_parking_system/view/booking/booking_page.dart';
import 'package:smart_parking_system/view/home_screen.dart';
import 'package:smart_parking_system/view/profile/profile_page.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({Key? key}) : super(key: key);

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  // Use 'const' for widgets to avoid unnecessary rebuilds
  final List<Widget> _widgetOptions = const [
    HomeScreen(),
    BookingPage(),

    // PickParkingSlot(
    //   receivedData: 'done',
    // ),
    // DateSelectionPage(),
    ProfilePage(),
  ];
  int _selectedIndex = 0; // Change 'selectedIndex' to '_selectedIndex'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AdaptiveTheme.of(context).mode.isDark ? Colors.black54 : Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
            child: GNav(
              rippleColor: AdaptiveTheme.of(context).mode.isDark ? const Color.fromRGBO(241, 248, 255, 1) : const Color.fromRGBO(241, 248, 255, 1), // tab button ripple color when pressed
              haptic: true, // haptic feedback
              tabBorderRadius: 90,
              textStyle: const TextStyle(fontSize: 16, fontFamily: "Lato"),

              curve: Curves.easeInCubic, // tab animation curves
              duration: const Duration(milliseconds: 900), // tab animation duration
              gap: 8, // the tab button gap between icon and text
              color: AdaptiveTheme.of(context).mode.isDark ? Colors.black54 : Colors.white, // unselected icon color
              activeColor: const Color(0xff0026c2), // selected icon and text color
              iconSize: 24, // tab button icon size

              tabBackgroundColor: AdaptiveTheme.of(context).mode.isDark ? const Color.fromRGBO(241, 248, 255, 1) : const Color.fromRGBO(241, 248, 255, 1), // selected tab background color
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 9),

              tabs: [
                GButton(
                  icon: CupertinoIcons.home,
                  text: 'Home',
                  textStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  iconSize: 25,
                  iconColor: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
                ),
                GButton(
                  icon: CupertinoIcons.calendar_today,
                  iconSize: 25,
                  textStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  text: 'Booking', // Change 'Likes' to 'Booking'
                  iconColor: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
                ),
                GButton(
                  icon: CupertinoIcons.profile_circled,
                  text: 'Profile',
                  textStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  iconSize: 28,
                  iconColor: AdaptiveTheme.of(context).mode.isDark ? Colors.white : Colors.black,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
