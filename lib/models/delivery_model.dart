import 'item_model.dart';

class DeliveryModel{
  String? orderId;
  String? name;
  String? address;
  String? phoneNumber;
  String? dueDate;
  List<dynamic>? items;
  String assignedDriver = "";
  String? itemsString; 
  String? status;

  DeliveryModel(this.name, this.address, this.phoneNumber,this.dueDate,this.itemsString);

  Map<String, dynamic> toJson() => {
    'orderId': orderId, 
    'name': name, 
    'address': address, 
    'phoneNumber': phoneNumber,
    'assignedDriver':assignedDriver,
    'items': items!.map((item) => item.toJson()).toList(),
    'status': status,
    //'dueDate': dueDate
  };

  DeliveryModel.fromSnapshot(snapshot)
    : orderId = snapshot.id,
      name = snapshot.data()['name'],
      address = snapshot.data()['address'],
      phoneNumber = snapshot.data()['phoneNumber'],
      assignedDriver = snapshot.data()['assignedDriver'],
      dueDate = snapshot.data()['dueDate'],
      items = snapshot.data()['items'],
      status = snapshot.data()['status'];



  // @override
  //   String toString() {
  //       return "Name: " + this.name! + "\nAddress: " + this.address! + "\nPhone Number: " + this.phoneNumber!;
  //   }
}