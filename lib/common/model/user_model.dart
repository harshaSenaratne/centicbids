class User {
  String uid;
  String email;
  String token;

  User({this.email, this.uid,this.token});

  User fromMap(Map<String, dynamic> json) {
    return User(
      uid: json["uid"] == null ? null : json["uid"],
      email: json["email"] == null ? null : json["email"],
      token: json["token"] == null ? null : json["token"],
    );
  }

  Map<String, dynamic> toMap() => {
    "uid": uid == null ? null : uid,
    "email": email == null ? null : email,
    "token": token == null ? null : token

  };
}
