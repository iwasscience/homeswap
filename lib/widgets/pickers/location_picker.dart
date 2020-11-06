// import 'package:flutter/material.dart';
// import '../../credentials.dart';
// import 'dart:async';
// import 'package:geocoder/geocoder.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'dart:math';

// const kGoogleApiKey = PLACES_API_KEY;

// GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

// class GoogleSearchLocation extends StatefulWidget {
//   // final String text;

//   // GoogleSearchLocation(this.text);

//   @override
//   GoogleSearchLocationState createState() => GoogleSearchLocationState();
// }

// class GoogleSearchLocationState extends State<GoogleSearchLocation> {
//   String _pickedLocation = '';

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 313,
//       height: 50,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(5),
//         border: Border.all(
//           color: Color(0xFF3E4067),
//         ),
//       ),
//       child: (_pickedLocation != '' &&
//               _pickedLocation != null) //TODO: == null fall auch abdecken!!
//           ? Text('You are in: $_pickedLocation')
//           : TextField(
//               onTap: () async {
//                 // show input autocomplete with selected mode
//                 // then get the Prediction selected
//                 Prediction p = await PlacesAutocomplete.show(
//                     context: context, apiKey: kGoogleApiKey);
//                 final locationData = displayPrediction(p).then((location) {
//                   setState(() {
//                     _pickedLocation = location;
//                     print('picked location!');
//                     print(_pickedLocation);
//                   });
//                 });

//                 //FocusScope.of(context).unfocus();
//                 //Navigator.of(context).pop();
//                 // todo: Trigger keyboard close after selection..
//               },
//               //onChanged: (value) {},
//               decoration: InputDecoration(
//                   hintText: "Enter Location",
//                   hintStyle: TextStyle(
//                     fontSize: 12,
//                     color: Color(0xFF464A7E),
//                   ),
//                   suffixIcon: Icon(Icons.search),
//                   contentPadding: EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 20,
//                   )),
//             ),
//       //),
//       //],
//       //),
//     );
//   }

// // Der Button kann irgendwo in der App sein! display prediction ist einfach nur eine funktion, die beliebig
// // durch einen import verwendet werden kann!

//   Future<String> displayPrediction(Prediction p) async {
//     if (p != null) {
//       PlacesDetailsResponse detail =
//           await _places.getDetailsByPlaceId(p.placeId);

//       var placeId = p.placeId;
//       double lat = detail.result.geometry.location.lat;
//       double lng = detail.result.geometry.location.lng;
//       String street = detail.result.geometry.location.toString();
//       String loc = detail.result.formattedAddress.toString();

//       var address = await Geocoder.local.findAddressesFromQuery(p.description);

//       //print(lat);
//       //print(lng);
//       // print(street);
//       // print(loc);
//       //print(address.first.addressLine);
//       //print(address.first.countryName);
//       //print(address.first.postalCode);
//       //print(address.first.adminArea);
//       //print(address.first.featureName);
//       //print(address.first.locality);

//       return address.first.locality;
//       //return address.first.addressLne;
//     }
//   }

//   String get pickedLocation => _pickedLocation != '' ? _pickedLocation : '';
// }
