import 'package:cloud_firestore/cloud_firestore.dart';

import 'bidder_model.dart';

class ProductModel {
  ProductModel(
      {this.id,
      this.name,
      this.bidActive,
      this.basePrice,
      this.currentBid,
      this.description,
      this.bidEndDateTime,
      this.imagePath,
      this.createdDt,
      this.bidder});

  String id;
  String name;
  int basePrice;
  int currentBid;
  String description;
  Timestamp bidEndDateTime;
  String imagePath;
  bool bidActive;
  Timestamp createdDt;
  Bidder bidder = Bidder();

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
      id: json["id"] == null ? null : json["id"],
      name: json["name"] == null ? null : json["name"],
      bidActive: json["bid_active"] == null ? null : json["bid_active"],
      basePrice: json["base_price"] == null ? null : json["base_price"],
      currentBid: json["current_bid"] == null ? null : json["current_bid"],
      description: json["description"] == null ? null : json["description"],
      imagePath: json["image_path"] == null ? null : json["image_path"],
      bidEndDateTime: json["bid_end_dt"] == null ? null : json['bid_end_dt'],
      bidder: json['highest_bidder'] == null
          ? new Bidder()
          : Bidder().fromMap(json['highest_bidder']),
      createdDt: json["created_dt"] == null ? null : json['created_dt']);

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "bid_active": bidActive == null ? null : bidActive,
        "base_price": bidActive == null ? null : bidActive,
        "current_bid": bidActive == null ? null : bidActive,
        "description": bidActive == null ? null : bidActive,
        "image_path": bidActive == null ? null : bidActive,
        "bid_end_dt": bidEndDateTime == null ? null : bidEndDateTime,
        "highest_bidder": bidder?.toMap()
      };
}

