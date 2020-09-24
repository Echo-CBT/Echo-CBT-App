class User {
  String uid;
  String name;
  String email;
  String mobile;

  User({
    this.uid,
    this.name,
    this.email,
    this.mobile,
  });

  factory User.fromJson(dynamic json) {
    return User(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
      mobile: json["mobile"],
    );
  }

  factory User.fromBackend(dynamic json) {
    return User(
      uid: json["uid"].toString(),
      name: json["name"].toString(),
      mobile: json["mobile"].toString(),
      email: json["email"].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "mobile": mobile,
      };
}
