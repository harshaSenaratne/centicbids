class Bidder {
  String uid;
  int amount;

  Bidder({this.amount, this.uid});

  Bidder fromMap(Map<String, dynamic> json) {
    return Bidder(
      uid: json["uid"] == null ? null : json["uid"],
      amount: json["amount"] == null ? null : json["amount"],
    );
  }

  Map<String, dynamic> toMap() => {
    "uid": uid == null ? null : uid,
    "amount": amount == null ? null : amount
  };
}
