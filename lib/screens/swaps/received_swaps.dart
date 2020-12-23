// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import '../../constants.dart';
// import '../../widgets/property_style.dart';
// import '../../widgets/property_detail.dart';
// import 'package:intl/intl.dart';

// class ReceivedSwapsScreenLUL extends StatelessWidget {
//   ReceivedSwapsScreen(this.isPremium);

//   final bool isPremium;

//   Widget buildRequest(
//       dynamic currentProperty,
//       String currentUserId,
//       BuildContext context,
//       int documentLength,
//       requestedByPropertyList,
//       List<Timestamp> startDates,
//       List<Timestamp> endDates) {
//     List<Timestamp> startDates_copy = startDates;
//     List<Timestamp> endDates_copy = endDates;

//     // List<Timestamp> startDatesFinal = [];
//     // List<Timestamp> endDatesFinal = [];
//     Timestamp startDateFinal = Timestamp.now();
//     Timestamp endDateFinal = Timestamp.now();
//     int index = 0;

//     for (var i = 0; i <= documentLength - 1; i++) {
//       if (requestedByPropertyList.contains(currentProperty.id)) {
//         // wo enthält requestedbypropertylist die request für eine proeprty die gerendert werden soll? im selben index sind in den beiden timestamp listen die start/end dates der request
//         index = requestedByPropertyList
//             .indexWhere((element) => element == currentProperty.id);
//         startDateFinal = startDates_copy[index];
//         endDateFinal = endDates_copy[index];
//         // startDatesFinal.add(startDates_copy[index]);
//         // endDatesFinal.add(endDates_copy[index]);
//       }
//     }
//     return Card(
//       child: ListTile(
//         leading: currentProperty.data()['userProfileImage'] == null
//             ? CircleAvatar(
//                 radius: 25,
//                 backgroundImage: AssetImage(
//                     "assets/images/profile_default.jpg"), // no matter how big it is, it won't overflow
//               )
//             : CircleAvatar(
//                 radius: 25,
//                 backgroundImage:
//                     NetworkImage(currentProperty.data()['userProfileImage']),
//               ),
//         title: Text(
//           //'${currentProperty.data()['username']}, ${currentProperty.data()['location']}',
//           '${currentProperty.data()['username']}',
//           style: TextStyle(fontSize: 16, color: Colors.black),
//         ),
//         subtitle: Text(
//           '${DateFormat.yMd().format(startDateFinal.toDate())} - ${DateFormat.yMd().format(endDateFinal.toDate())}',
//           style: TextStyle(fontSize: 15),
//         ),
//         //trailing: Icon(Icons.check_box),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             InkWell(
//                 onTap: () async {
//                   if (isPremium) {
//                     SnackBar snackBar = SnackBar(
//                       content: Text(
//                         'Accepting swap requests requires a premium account.',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       backgroundColor: Color(0xFF4845c7),
//                     );
//                     Scaffold.of(context).showSnackBar(snackBar);
//                   } else {
//                     QuerySnapshot activeRequests = await FirebaseFirestore
//                         .instance
//                         .collection('users')
//                         .doc(currentUserId)
//                         .collection('requests')
//                         .where('status', isEqualTo: "accepted")
//                         .get();

//                     if (activeRequests.docs.length >= 5) {
//                       SnackBar snackBar = SnackBar(
//                         content: Text(
//                           'You reached the limit of five active Swaps.',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         backgroundColor: Color(0xFF4845c7),
//                       );
//                       Scaffold.of(context).showSnackBar(snackBar);
//                     } else {
//                       FirebaseFirestore.instance
//                           .collection('users')
//                           .doc(currentUserId)
//                           .collection('requests')
//                           .where('type', isEqualTo: 'received')
//                           // update the received request status of the property that has been accepted or declined
//                           .where('selectedPropertyId',
//                               isEqualTo: currentProperty.id)
//                           .get()
//                           .then((filteredAcceptedProperty) =>
//                               filteredAcceptedProperty.docs
//                                   .forEach((accProperty) {
//                                 accProperty.reference
//                                     .update({'status': 'accepted'});
//                               }));
//                       FirebaseFirestore.instance
//                           .collection('users')
//                           // filter den user der mir die request geschickt hat und update seine send request die er mir geschickt hat auf accepted
//                           .doc(currentProperty.data()['userId'])
//                           .collection('requests')
//                           .where('type', isEqualTo: 'send')
//                           // update the received request status of the propertie that has been accepted or declined
//                           .where('RequestSendToUser', isEqualTo: currentUserId)
//                           .get()
//                           .then((filteredAcceptedProperty) =>
//                               filteredAcceptedProperty.docs
//                                   .forEach((accProperty) {
//                                 accProperty.reference
//                                     .update({'status': 'accepted'});
//                               }));
//                     }
//                   }
//                 },
//                 child: Icon(
//                   Icons.check,
//                   color: Colors.greenAccent,
//                 )),
//             //IconButton(icon: Icon(Icons.check), onPressed: () {}),
//             SizedBox(
//               width: 20,
//             ),
//             InkWell(
//                 onTap: () async {
//                   QuerySnapshot activeRequests = await FirebaseFirestore
//                       .instance
//                       .collection('users')
//                       .doc(currentUserId)
//                       .collection('requests')
//                       .where('status', isEqualTo: "accepted")
//                       .get();

//                   if (activeRequests.docs.length >= 5) {
//                     SnackBar snackBar = SnackBar(
//                       content: Text(
//                         'You reached the limit of five active Swaps.',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       backgroundColor: Color(0xFF4845c7),
//                     );
//                     Scaffold.of(context).showSnackBar(snackBar);
//                   } else {
//                     FirebaseFirestore.instance
//                         .collection('users')
//                         .doc(currentUserId)
//                         .collection('requests')
//                         .where('type', isEqualTo: 'received')
//                         // update the received request status of the property that has been accepted or declined
//                         .where('selectedPropertyId',
//                             isEqualTo: currentProperty.id)
//                         .get()
//                         .then((filteredAcceptedProperty) =>
//                             filteredAcceptedProperty.docs
//                                 .forEach((accProperty) {
//                               accProperty.reference.delete();
//                             }));
//                     FirebaseFirestore.instance
//                         .collection('users')
//                         // filter den user der mir die request geschickt hat und update seine send request die er mir geschickt hat auf accepted
//                         .doc(currentProperty.data()['userId'])
//                         .collection('requests')
//                         .where('type', isEqualTo: 'send')
//                         // update the received request status of the propertie that has been accepted or declined
//                         .where('RequestSendToUser', isEqualTo: currentUserId)
//                         .get()
//                         .then((filteredAcceptedProperty) =>
//                             filteredAcceptedProperty.docs
//                                 .forEach((accProperty) {
//                               accProperty.reference.delete();
//                             }));
//                   }
//                 },
//                 child: Icon(
//                   Icons.delete_outline,
//                   color: Colors.redAccent,
//                 )),
//             SizedBox(
//               width: 20,
//             ),
//             // InkWell(
//             //     onTap: () {
//             //       print('chat');
//             //     },
//             //     child: Icon(
//             //       Icons.chat,
//             //       color: Colors.yellowAccent,
//             //     )),
//             SizedBox(
//               width: 5,
//             ),
//           ],
//         ),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Detail(
//                   currentProperty.data()['title'],
//                   currentProperty.data()['username'],
//                   currentProperty.data()['userImage'],
//                   //currentProperty.data()['location'],
//                   '', // not used in detail
//                   currentProperty.data()['userId'],
//                   currentUserId,
//                   currentProperty.id,
//                   true,
//                   // currentProperty.data()['latitude'],
//                   // currentProperty.data()['longitude'],
//                   currentProperty.data()['bathrooms'],
//                   currentProperty.data()['bedrooms'],
//                   currentProperty.data()['kitchen'],
//                   currentProperty.data()['workspaces'],
//                   currentProperty.data()['sqm'],
//                   currentProperty.data()['firstAdditionalImage'],
//                   currentProperty.data()['secondAdditionalImage'],
//                   false,
//                   currentProperty.data()['userProfileImage'],
//                   currentProperty.data()['userMail'],
//                   '',
//                   currentProperty.data()['locationFullPlaceId'],
//                   false),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     // once we got the currently logged in user, return streambuilder and build the list view new for every new property
//     //return StreamBuilder(
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .collection('requests')
//             .where('type', isEqualTo: 'received')
//             .where('status', isEqualTo: "pending")
//             .snapshots(),
//         // whenever the properties collection receives a new value, the function inside of the builder argument is executed
//         builder: (ctx, streamSnapshot) {
//           if (streamSnapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               //child: CircularProgressIndicator(),
//               child: SpinKitRotatingCircle(
//                 color: kPrimaryColor,
//                 size: 50.0,
//               ),
//             );
//           }
//           if (!streamSnapshot.hasData) {
//             return Text('Loading');
//           }

//           //final documents = streamSnapshot.data.docs;
//           final requestedBy = streamSnapshot.data.docs;

//           List<dynamic> requestedByPropertyList = ['default'];
//           List<Timestamp> startDates = [Timestamp.now()];
//           List<Timestamp> endDates = [Timestamp.now()];

//           //requestedByPropertyList.indexWhere((element) => false)

//           // Create list of users that requested a swap with the current user NEW: and add the property of interest from the current user
//           for (var i = 0; i <= requestedBy.length - 1; i++) {
//             requestedByPropertyList
//                 .add(requestedBy[i].data()['selectedPropertyId']);
//             startDates.add(requestedBy[i].data()['selectedStartDate']);
//             endDates.add(requestedBy[i].data()['selectedEndDate']);
//             //ADD MYPROPERTY FROM COLLECTION ASWELL
//           }

//           // create stream of properties filtered by the users that the current user has received requests from
//           return StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('properties')
//                   //.where('id', whereIn: requestedByPropertyList)
//                   //.orderBy('createdAt', descending: true)
//                   .snapshots(),
//               // whenever the properties collection receives a new value, the function inside of the builder argument is executed
//               builder: (ctx, streamSnapshot) {
//                 if (streamSnapshot.connectionState == ConnectionState.waiting) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//                 if (!streamSnapshot.hasData) {
//                   return Text('Loading');
//                 }

//                 //final documents = streamSnapshot.data.docs;
//                 final documents = streamSnapshot.data.docs;

//                 // anstelle von vorher documents und mit firebase whereIn filtern, filtert die folgende for schleife dasselbe manuell
//                 List<dynamic> finalProperties = [];

//                 // filter alle gelisteten properties nach denen, von denen der aktuelle pending swap requests hat
//                 for (var i = 0; i <= documents.length - 1; i++) {
//                   if (requestedByPropertyList
//                       .contains(documents[i].data()['id'])) {
//                     finalProperties.add(documents[i]);
//                   }
//                 }

//                 if (finalProperties.length == 0) {
//                   return Padding(
//                     padding:
//                         const EdgeInsets.only(left: 15, right: 15, top: 25),
//                     child: Text('no pending received requests.'),
//                   );
//                 } else {
//                   return ListView.builder(
//                     // order messages from bottom to top
//                     //reverse: true,
//                     itemCount: finalProperties.length,
//                     itemBuilder: (ctx, index) => buildRequest(
//                         finalProperties[index],
//                         user.uid,
//                         context,
//                         finalProperties.length,
//                         requestedByPropertyList,
//                         startDates,
//                         endDates),
//                   );
//                 }
//               });
//         });
//   }
// }
