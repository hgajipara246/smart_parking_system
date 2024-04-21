import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parking_system/view/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode, isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final bool isLoggedIn;

  const MyApp({super.key, this.savedThemeMode, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primarySwatch: Colors.orange, // Set primary color to orange
        hintColor: Colors.blue,
        textTheme: const TextTheme(bodyText2: TextStyle(fontFamily: "Lato")),
        errorColor: Colors.red,
      ),
      dark: ThemeData(
        useMaterial3: true,

        brightness: Brightness.dark,
        primarySwatch: Colors.orange, // Set primary color to orange
        hintColor: Colors.blue,
        textTheme: const TextTheme(bodyText2: TextStyle(fontFamily: "Lato")),
        errorColor: Colors.red,
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Automate Park',
        theme: theme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
