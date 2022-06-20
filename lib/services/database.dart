import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliveryportal/models/delivery_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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

deliveryUpdatedTrue() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('delivery_updated', true);
  print("sent data to database");
}

deliveryUpdatedFalse() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('delivery_updated', false);
  print("set updated false");
}

Future<bool> isUpdated() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('delivery_updated') ?? false;
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

Future sendDeliveryDataToDB(name, address, phoneNumber) async {
  await FirebaseFirestore.instance.collection("deliveries").add({
    'name': name,
    'address':address,
    'phoneNumber': phoneNumber,
    'assignedDriver': ''
  });
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('delivery_updated', true);  
}

Future<List<DeliveryModel>> test () async {
  var data = await FirebaseFirestore.instance
    .collection('deliveries')
    .get();
  return List.from(data.docs.map((e) => DeliveryModel.fromSnapshot(e)));
}

Future getAllDeliveries() async {
  
  var data = await FirebaseFirestore.instance
    .collection('deliveries')
    .get();

  var listOfdata = List.from(data.docs.map((e) => DeliveryModel.fromSnapshot(e))); 
  return data;
  //return deliveryList;
}

Future getDeliveryDataFromDB() async {
  await FirebaseFirestore.instance
    .collection('deliveries')
    .get()
    .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          String? orderId = doc['id'];
          String? name =doc["name"];
          String? address = doc["address"];
          String? phonenumber = '${doc['phoneNumber']}';
          String? assignedDriver = doc['assignedDriver'];

          //deliveryList.add(DeliveryModel(orderId,name, address, phonenumber, assignedDriver));
            // print(doc["name"]);
            // print(doc["address"]);
            // print(doc["phoneNumber"]);
            // print("----");
        });
    });
  print("got from database");
  //return deliveryList;
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