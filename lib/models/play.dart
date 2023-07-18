class User {
  int? userId;
  String? name;
  String? email;
  String? phone;
  String? type;
  String? token;
  String? renewToken;

  User(
      {this.userId,
      this.name,
      this.email,
      this.phone,
      this.type,
      this.token,
      this.renewToken});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        userId: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        type: json["type"],
        token: json["token"],
        renewToken: json["renewToken"]);
  }
}
