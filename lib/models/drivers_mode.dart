class DriversModel{
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? availability;
  int? deliveries_assigned;
  int? deliveries_completed;

  DriversModel(this.id, this.name, this.email, this.phoneNumber, this.deliveries_completed, this.deliveries_assigned);

  DriversModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    deliveries_assigned = json['deliveries_assigned'];
    deliveries_completed = json['deliveries_completed'];
    availability = json['availability'];
  }

  // drivers map snapshot to drivers list
  DriversModel.fromSnapshot(snapshot)
    : id = snapshot.id,
      name = snapshot.data()['name'],
      email = snapshot.data()['email'],
      phoneNumber = snapshot.data()['phoneNumber'],
      deliveries_assigned = snapshot.data()['deliveries_assigned'],
      deliveries_completed = snapshot.data()['deliveries_completed'],
      availability = snapshot.data()['availability'];
}