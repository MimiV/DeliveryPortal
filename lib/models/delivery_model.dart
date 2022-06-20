class DeliveryModel{
  String? orderId;
  String? name;
  String? address;
  String? phoneNumber;
  String? assignedDriver;

  DeliveryModel(this.orderId,this.name, this.address, this.phoneNumber, this.assignedDriver);

  Map<String, dynamic> toJson() => {
    'orderId': orderId, 
    'name': name, 
    'address': address, 
    'phoneNumber': phoneNumber,
    'assignedDriver':assignedDriver
  };

  DeliveryModel.fromSnapshot(snapshot)
    : orderId = snapshot.id,
      name = snapshot.data()['name'],
      address = snapshot.data()['address'],
      phoneNumber = snapshot.data()['phoneNumber'],
      assignedDriver = snapshot.data()['assignedDriver'];


  // @override
  //   String toString() {
  //       return "Name: " + this.name! + "\nAddress: " + this.address! + "\nPhone Number: " + this.phoneNumber!;
  //   }
}