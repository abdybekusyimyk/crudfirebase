// import 'dart:convert';

class ToDuModel {
  ToDuModel(
      {this.id,
      required this.title,
      required this.name,
      required this.isselect});
  String? id;
  final String title;
  final String name;
  final bool isselect;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "title": title,
      "name": name,
      "isselect": isselect
    };
  }

  factory ToDuModel.fromMap(Map<String, dynamic> map) {
    return ToDuModel(
        title: map["title"],
        name: map["name"],
        isselect: map["isselect"] as bool);
  }

  // JsonEncoder toJson() => json.encoder;
  // factory ToDuModel.fromJson(String sourse) =>
  //     ToDumodel.fromMap(json.decode(source) as Map<String, dynamic>);
}
