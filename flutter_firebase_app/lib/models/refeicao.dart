import 'package:cloud_firestore/cloud_firestore.dart';

class Refeicao {
  String? id;
  String? dayOfWeek;
  String? name;
  String? image;
  String? description;

  Refeicao({
    this.dayOfWeek,
    this.name,
    this.image,
    this.description,
  });

  // Refeicao.fromJson(Map<String, dynamic> json) {
  //   dayOfWeek = json['day_of_week'];
  //   name = json['name'];
  //   image = json['image'];
  //   description = json['description'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['day_of_week'] = this.dayOfWeek;
  //   data['name'] = this.name;
  //   data['image'] = this.image;
  //   data['description'] = this.description;
  //   return data;
  // }

  Map<String, dynamic> toMap() {
    return {
      'day_of_week': dayOfWeek,
      'name': name,
      'image': image,
      'description': description,
      'id': id,
    };
  }

  Refeicao.fromMap(DocumentSnapshot<Map<String, dynamic>> map)
      : dayOfWeek = map.data()!["day_of_week"],
        name = map.data()!["name"],
        image = map.data()!["image"],
        description = map.data()!["description"],
        id = map.id;
}
