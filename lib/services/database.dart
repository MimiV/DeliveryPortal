import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliveryportal/models/delivery_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:username_gen/username_gen.dart';

import '../models/drivers_mode.dart';


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

Future<QuerySnapshot<Map<String, dynamic>>> getAllDeliveries() async {
    return await FirebaseFirestore.instance.collection('deliveries').get();
}

Future<QuerySnapshot<Map<String, dynamic>>> getAllDrivers() async {
    return await FirebaseFirestore.instance.collection('drivers').get();
}

//Add drivers to firebase firestore
Future<void> addDriverToDB(name,email, phoneNumber) async {
  await FirebaseFirestore.instance.collection("drivers").add({
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
    'deliveries_assigned': 0,
    'deliveries_completed': 0
  });
}

// register driver to firebase auth
Future<void> registerDriver(name, email,phoneNumber) async {
  final auth = FirebaseAuth.instance;
  final driver = await auth.createUserWithEmailAndPassword(
      email: email, password: phoneNumber);
  final user = await driver.user;
  final userId = user!.uid;
  await FirebaseFirestore.instance.collection("drivers").doc(userId).set({
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
    'deliveries_assigned': 0,
    'deliveries_completed': 0
  });
}

// return all drivers from firebase firestore
Future<List<DriversModel>> getDrivers() async {
  final QuerySnapshot<Map<String, dynamic>> drivers = await getAllDrivers();
  final List<DriversModel> driversList = [];
  drivers.docs.forEach((doc) {
    driversList.add(DriversModel.fromSnapshot(doc));
  });
  return driversList;
}


Future<List<DeliveryModel>> getDeliveries() async {
  final QuerySnapshot<Map<String, dynamic>> deliveries = await getAllDeliveries();
  final List<DeliveryModel> deliveryList = [];
  deliveries.docs.forEach((doc) {
    deliveryList.add(DeliveryModel.fromSnapshot(doc));
  });
  return deliveryList;
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

// Future getDrivers() async{
//    await FirebaseFirestore.instance
//     .collection('drivers_test')
//     .get()
//     .then((QuerySnapshot querySnapshot) {
//         querySnapshot.docs.forEach((doc) {
//             print(doc["name"]);
//             print(doc["deliveries"]);
//             print(doc["completed"]);
//             print("----");
//         });
//     });
//     print("done");
// }

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