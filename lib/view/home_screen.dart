// import 'dart:convert';
//
// import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:smart_parking_system/model/remotely_model.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late FirebaseAuth firebaseAuth;
//   late FirebaseFirestore firebaseFirestore;
//
//   UserModel userModel = UserModel();
//   bool isLoading = true;
//
//   String profileImage() {
//     String profileImagePath = "assets/images/profile/person.png"; // Default profile image path
//
//     // Check user's gender and update profile image path accordingly
//     if (userModel.gender == "male") {
//       profileImagePath = "assets/images/profile/person.png";
//     } else if (userModel.gender == "female") {
//       profileImagePath = "assets/images/profile/avatarGirl.png";
//     }
//     return profileImagePath;
//   }
//
//   @override
//   void initState() {
//     firebaseAuth = FirebaseAuth.instance;
//     firebaseFirestore = FirebaseFirestore.instance;
//     getUser();
//     super.initState();
//   }
//
//   void getUser() {
//     CollectionReference users = firebaseFirestore.collection("user");
//     users.doc(firebaseAuth.currentUser!.uid).get().then((value) {
//       debugPrint("User Home  --------> ${jsonEncode(value.data())}");
//       userModel = userModelFromJson(jsonEncode(value.data()));
//       setState(() {
//         isLoading = false;
//       });
//     }).catchError((error) {
//       debugPrint("Failed to get user  : $error");
//       setState(() {
//         isLoading = false;
//       });
//     });
//   }
//
//   String qrData = 'https://www.youtube.com/watch?v=JpiqW0bm22o'; // Initial QR data
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
//       appBar: AppBar(
//         backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
//         title: const Text(
//           'Automate Park',
//           style: TextStyle(
//             fontFamily: "Lato",
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : AdaptiveTheme(
//               light: ThemeData.light(),
//               dark: ThemeData.dark(),
//               initial: AdaptiveThemeMode.light,
//               builder: (theme, darkTheme) {
//                 return SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   scrollDirection: Axis.vertical,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Hello,",
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Theme.of(context).textTheme.headline1!.color,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 30,
//                               backgroundColor: const Color(0xffececfd),
//                               backgroundImage: AssetImage(
//                                 profileImage(),
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "${userModel.name}",
//                                   style: TextStyle(
//                                     fontSize: 24,
//                                     color: Theme.of(context).textTheme.headline1!.color,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   "${userModel.email}",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Theme.of(context).textTheme.headline1!.color,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           "Your Recent Activity",
//                           style: TextStyle(
//                             fontSize: 20,
//                             color: Theme.of(context).textTheme.headline1!.color,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         // SizedBox(
//                         //   height: 150,
//                         //   width: 150,
//                         //   child: PrettyQrView(
//                         //     decoration: PrettyQrDecoration(
//                         //       shape: PrettyQrRoundedSymbol(
//                         //         borderRadius: BorderRadius.circular(50),
//                         //       ),
//                         //       image: PrettyQrDecorationImage(
//                         //         image: AssetImage(
//                         //           "assets/images/Purple Badge Car.png",
//                         //         ),
//                         //       ),
//                         //     ),
//                         //     qrImage: QrImage(
//                         //       QrCode.fromData(
//                         //         data: "https://www.instagram.com/",
//                         //         errorCorrectLevel: QrErrorCorrectLevel.H,
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
//
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             QrImageView(
//                               data: qrData,
//                               gapless: true,
//                               eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.circle),
//                               dataModuleStyle: QrDataModuleStyle(
//                                 dataModuleShape: QrDataModuleShape.circle,
//                               ),
//                               foregroundColor: Color(0xff050f49),
//                               version: QrVersions.auto,
//                               size: 200.0,
//                             ),
//                             SizedBox(height: 20),
//                             ElevatedButton(
//                               onPressed: () {
//                                 // Update QR data here, you can fetch it from an API, user input, etc.
//                                 String newData = generateRandomData(); // Example function to generate random data
//                                 setState(() {
//                                   qrData = newData;
//                                 });
//                               },
//                               child: Text('Generate New QR Code'),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
//
// String generateRandomData() {
//   return DateTime.now().millisecondsSinceEpoch.toString();
// }

// --------------------------------------------------------------------------------------------------------------------------------------------------------

import 'dart:convert';
import 'dart:typed_data';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:smart_parking_system/model/remotely_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth? firebaseAuth;
  FirebaseFirestore? firebaseFirestore;
  FirebaseStorage? firebaseStorage;

  UserModel userModel = UserModel();
  bool isLoading = true;
  String qrData = 'https://www.youtube.com/watch?v=JpiqW0bm22o'; // Initial QR data

  String profileImage() {
    String profileImagePath = "assets/images/profile/person.png"; // Default profile image path

    // Check user's gender and update profile image path accordingly
    if (userModel.gender == "male") {
      profileImagePath = "assets/images/profile/person.png";
    } else if (userModel.gender == "female") {
      profileImagePath = "assets/images/profile/avatarGirl.png";
    }
    return profileImagePath;
  }

  @override
  void initState() {
    firebaseAuth = FirebaseAuth.instance;
    firebaseFirestore = FirebaseFirestore.instance;
    firebaseStorage = FirebaseStorage.instance;
    getUser();
    super.initState();
  }

  void getUser() {
    CollectionReference users = firebaseFirestore!.collection("user");
    users.doc(firebaseAuth!.currentUser!.uid).get().then((value) {
      debugPrint("User Home  --------> ${jsonEncode(value.data())}");
      userModel = userModelFromJson(jsonEncode(value.data()));
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      debugPrint("Failed to get user  : $error");
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
      appBar: AppBar(
        backgroundColor: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
        title: const Text(
          'Automate Park',
          style: TextStyle(
            fontFamily: "Lato",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : AdaptiveTheme(
              light: ThemeData.light(),
              dark: ThemeData.dark(),
              initial: AdaptiveThemeMode.light,
              builder: (theme, darkTheme) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello,",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.headline1!.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color(0xffececfd),
                              backgroundImage: AssetImage(
                                profileImage(),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${userModel.name}",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Theme.of(context).textTheme.headline1!.color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${userModel.email}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).textTheme.headline1!.color,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Your Recent Activity",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).textTheme.headline1!.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FutureBuilder<String>(
                              future: generateQRCodeUrl(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  String qrImageUrl = snapshot.data ?? '';
                                  return Column(
                                    children: [
                                      Image.network(qrImageUrl),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          generateQRCodeUrl().then(
                                            (url) {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text('Generated QR Code URL'),
                                                    content: SelectableText(url ?? ''),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: const Text('Close'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                        child: const Text('Store &  Generate New QR Code'),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<String> generateQRCodeUrl() async {
    // Generate QR code as image
    Uint8List qrImageData = await generateQRCodeImageData(qrData);

    // Upload QR code image to Firebase Storage
    String qrImagePath = await uploadQRCodeImage(qrImageData);

    return qrImagePath;
  }

  Future<Uint8List> generateQRCodeImageData(String qrString) async {
    final qrCode = QrCode.fromData(
      data: qrString,
      errorCorrectLevel: QrErrorCorrectLevel.H,
    );
    final painter = QrPainter(
      gapless: true,
      eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.circle),
      dataModuleStyle: QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.circle,
      ),
      data: "https://www.youtube.com/watch?v=lY8Mwtst_Mk&list=RDGMEMCMFH2exzjBeE_zAHHJOdxgVM9Dk9dyuaZhw&index=6",
      color: AdaptiveTheme.of(context).mode.isDark ? const Color.fromRGBO(241, 248, 255, 1) : Color(0xff080d65),
      version: QrVersions.auto,
    );
    final qrImageData = await painter.toImageData(200.0);

    return qrImageData!.buffer.asUint8List();
  }

  Future<String> uploadQRCodeImage(Uint8List qrImageData) async {
    String filePath = 'qrcodes/${firebaseAuth!.currentUser!.uid}.png';
    Reference storageReference = firebaseStorage!.ref().child(filePath);
    UploadTask uploadTask = storageReference.putData(qrImageData);
    debugPrint("---------------------------------------------- IMAGE STORED SUCCESSFULLY ----------------------------------------------");
    await uploadTask.whenComplete(() => null);

    String downloadUrl = await storageReference.getDownloadURL();
    return downloadUrl;
  }
}
