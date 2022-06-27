class Item{
  String? name;
  String? deliveryDriver;
  bool? confirmed; // initial scan
  bool? delivered; // scanned


  Item({
    this.name,
    this.deliveryDriver,
    this.confirmed,
    this.delivered
  });


  factory Item.fromJson(Map<String, dynamic> json) => Item(
    name: json["name"],
    deliveryDriver: json["deliveryDriver"],
    confirmed: json["confirmed"],
    delivered: json["delivered"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "deliveryDriver": deliveryDriver,
    "confirmed": confirmed,
    "delivered": delivered
  };

  Item.fromSnapshot(snapshot)
    : name = snapshot.data()['name'],
      deliveryDriver = snapshot.data()['deliveryDriver'],
      confirmed = snapshot.data()['confirmed'],
      delivered = snapshot.data()['delivered'];
}