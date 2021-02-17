import 'dart:convert';

class ContactModel{
  String name;
  String email;
  String phone;

  ContactModel({
    this.email,
    this.phone,
    this.name
});

  factory ContactModel.fromMap(Map<String,
      dynamic> json) => new ContactModel(
    name: json["name"],
    email: json["email"],
    phone: json["phone"]
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "email": email,
    "phone": phone,
  };
}

ContactModel contactFromJson(String str) {
  final jsonData = json.decode(str);
  return ContactModel.fromMap(jsonData);
}

String contactToJson(ContactModel data) {
  Map dyn = data.toMap();
  return json.encode(dyn);
}