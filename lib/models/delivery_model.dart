class DeliveryModel{
  int? orderId;
  String? name;
  String? address;
  String? phoneNumber;
  String? assignedDriver;

  DeliveryModel(this.orderId,this.name, this.address, this.phoneNumber, this.assignedDriver);


  @override
    String toString() {
        return "Name: " + name! + "\nAddress: " + address! + "\nPhone Number: " + phoneNumber!;
    }
}