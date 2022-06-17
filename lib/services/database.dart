import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:username_gen/username_gen.dart';

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


Future sendDriverData(String name, int deliveries, int completed) async {
  await FirebaseFirestore.instance.collection("drivers_test").add({
    'name': name,
    'deliveries':deliveries,
    'completed': completed
});
  print("sent data to database");
}

Future getDrivers() async{
   await FirebaseFirestore.instance
    .collection('drivers_test')
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
            print(doc["name"]);
            print(doc["deliveries"]);
            print(doc["completed"]);
            print("----");
        });
    });
    print("done");
}

generateDrivers(){
  String name = UsernameGen.generateWith(data: UsernameGenData(
        names: ['new names'],
        adjectives: ['new adjectives'],
    ),
    seperator: ' ');
  Random random = new Random();
  int deliveries = random.nextInt(100);
  int completed = random.nextInt(30);
  sendDriverData(name,deliveries,completed);
}