// import 'dart:convert';
//
// import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:smart_parking_system/model/parking_model.dart';
//
// import 'booking/payment_all_details.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   FirebaseAuth? firebaseAuth;
//   FirebaseFirestore? firebaseFirestore;
//   FirebaseStorage? firebaseStorage;
//
//   UserModel userModel = UserModel();
//   bool isLoading = true;
//
//   List<PaymentModel> paymentList = [];
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
//     firebaseStorage = FirebaseStorage.instance;
//     getUser();
//
//     getRecentPayments(); // Fetch recent payments
//     super.initState();
//   }
//
//   void getUser() {
//     CollectionReference users = firebaseFirestore!.collection("user");
//     users.doc(firebaseAuth!.currentUser!.uid).get().then((value) {
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
//   void getRecentPayments() {
//     CollectionReference payments = firebaseFirestore!.collection("paymentsDetails");
//     payments.orderBy('selectedDate', descending: true).limit(5).get().then((querySnapshot) {
//       List<PaymentModel> tempList = [];
//       querySnapshot.docs.forEach((doc) {
//         tempList.add(PaymentModel.fromSnapshot(doc));
//       });
//       setState(() {
//         paymentList = tempList;
//       });
//     }).catchError((error) {
//       debugPrint("Failed to get payments: $error");
//     });
//   }
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
//         automaticallyImplyLeading: false,
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
//                         const SizedBox(height: 20),
//                         Text(
//                           "Your Recent Activity",
//                           style: TextStyle(
//                             fontSize: 22,
//                             color: Theme.of(context).textTheme.headline1!.color,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           "Use recent activity for show your slot details",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Theme.of(context).textTheme.headline1!.color,
//                           ),
//                         ),
//                         const Divider(),
//                         const SizedBox(height: 8),
//                         paymentList.isEmpty
//                             ? Center(
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(top: 48.0),
//                                   child: Container(
//                                     child: Text(
//                                       "No Recent Activity Found!",
//                                       style: TextStyle(
//                                         color: Theme.of(context).textTheme.headline1!.color,
//                                       ),
//                                     ),
//                                     padding: const EdgeInsets.all(16),
//                                     decoration: BoxDecoration(
//                                       color: AdaptiveTheme.of(context).mode.isDark ? Colors.grey[850] : Colors.blue[50],
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             : ListView.builder(
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemCount: paymentList.length,
//                                 itemBuilder: (context, index) {
//                                   return buildPaymentItem(context, paymentList[index], index);
//                                 },
//                               ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
//
//   Widget buildPaymentItem(BuildContext context, PaymentModel payment, int index) {
//     int displayIndex = index + 1;
//
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PaymentAllDetails(payment: payment),
//           ),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           vertical: 8.0,
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             color: AdaptiveTheme.of(context).mode.isDark ? Colors.white12 : const Color.fromRGBO(241, 248, 255, 1),
//             borderRadius: BorderRadius.circular(10.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "${displayIndex}.", // Display index here
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         "Slot: ${payment.slotNumber}",
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "Date: ${payment.selectedDate}",
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "Time: ${payment.startTime} - ${payment.endTime}",
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "Amount: ₹${payment.total}",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: AdaptiveTheme.of(context).mode.isDark ? Colors.green : Colors.black, // Adjusted color based on theme
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 SizedBox(
//                   height: 100,
//                   width: 100,
//                   child: Stack(
//                     children: [
//                       payment.qrCodeUrl.isNotEmpty
//                           ? Image.network(
//                               payment.qrCodeUrl,
//                               fit: BoxFit.cover,
//                             )
//                           : Image.asset(
//                               'assets/images/spinner.gif',
//                               fit: BoxFit.cover,
//                             ),
//                       Positioned(
//                         right: 0,
//                         top: 0,
//                         child: Container(
//                           height: 35,
//                           width: 35,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
//                           ),
//                           child: PopupMenuButton(
//                             iconSize: 20,
//                             itemBuilder: (context) => [
//                               const PopupMenuItem(
//                                 height: 20,
//                                 value: 'delete',
//                                 child: Text('Delete'),
//                               ),
//                             ],
//                             onSelected: (value) {
//                               if (value == 'delete') {
//                                 // Delete the payment from the list
//                                 setState(() {
//                                   paymentList.remove(payment);
//                                 });
//                               }
//                             },
//                             icon: const Icon(Icons.more_vert),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:smart_parking_system/model/parking_model.dart';

import 'booking/payment_all_details.dart';

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

  List<PaymentModel> paymentList = [];

  String profileImage() {
    String profileImagePath = "assets/images/profile/person.png"; // Default profile image path

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

    getRecentPayments(); // Fetch recent payments
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

  void getRecentPayments() {
    CollectionReference payments = firebaseFirestore!.collection("paymentsDetails");
    payments.orderBy('selectedDate', descending: true).limit(5).get().then((querySnapshot) {
      List<PaymentModel> tempList = [];
      querySnapshot.docs.forEach((doc) {
        tempList.add(PaymentModel.fromSnapshot(doc));
      });
      setState(() {
        paymentList = tempList;
      });
    }).catchError((error) {
      debugPrint("Failed to get payments: $error");
    });
  }

  void deletePayment(PaymentModel payment) {
    firebaseFirestore!.collection("paymentsDetails").doc(payment.id).delete().then((_) {
      setState(() {
        paymentList.remove(payment);
      });
    }).catchError((error) {
      debugPrint("Failed to delete payment: $error");
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
        automaticallyImplyLeading: false,
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
                            color: Theme.of(context).textTheme.headlineMedium!.color,
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
                                    color: Theme.of(context).textTheme.headlineMedium!.color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${userModel.email}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).textTheme.headlineMedium!.color,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Your Recent Activity",
                          style: TextStyle(
                            fontSize: 22,
                            color: Theme.of(context).textTheme.headlineMedium!.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Use recent activity for show your slot details",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).textTheme.headlineMedium!.color,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(height: 8),
                        paymentList.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 48.0),
                                  child: Container(
                                    child: Text(
                                      "No Recent Activity Found!",
                                      style: TextStyle(
                                        color: Theme.of(context).textTheme.headlineMedium!.color,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: AdaptiveTheme.of(context).mode.isDark ? Colors.grey[850] : Colors.blue[50],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              )
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: paymentList.length,
                                itemBuilder: (context, index) {
                                  return buildPaymentItem(context, paymentList[index], index);
                                },
                              ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget buildPaymentItem(BuildContext context, PaymentModel payment, int index) {
    int displayIndex = index + 1;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentAllDetails(payment: payment),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AdaptiveTheme.of(context).mode.isDark ? Colors.white12 : const Color.fromRGBO(241, 248, 255, 1),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${displayIndex}.", // Display index here
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Slot: ${payment.slotNumber}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Date: ${payment.selectedDate}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Time: ${payment.startTime} - ${payment.endTime}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Amount: ₹${payment.total}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AdaptiveTheme.of(context).mode.isDark ? Colors.green : Colors.black, // Adjusted color based on theme
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      payment.qrCodeUrl.isNotEmpty
                          ? Image.network(
                              payment.qrCodeUrl,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/spinner.gif',
                              fit: BoxFit.cover,
                            ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AdaptiveTheme.of(context).mode.isDark ? Colors.black : const Color.fromRGBO(241, 248, 255, 1),
                          ),
                          child: PopupMenuButton(
                            iconSize: 20,
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                height: 20,
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                            onSelected: (value) {
                              if (value == 'delete') {
                                deletePayment(payment);
                              }
                            },
                            icon: const Icon(Icons.more_vert),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
