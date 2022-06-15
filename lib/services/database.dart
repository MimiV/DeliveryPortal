import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

// send data
sendData() {
  http.post(
      Uri.parse(
          "https://deliveryportal-1ab91-default-rtdb.firebaseio.com/testdata.json"),
      body: json.encode({
        'firstName': "bebe",
        'lastName': "vas",
        'email': "bebe@email.com",
      }));
}

// get data
getData() async {
  final response = await http.get(Uri.parse(
      "https://deliveryportal-1ab91-default-rtdb.firebaseio.com/testdata.json?"));
  print("response is?");

  final extractedData = json.decode(response.body) as Map<String, dynamic>;
  extractedData.forEach((profileId, profileData) {
    print(profileId);
    print(profileData);
  });
}
