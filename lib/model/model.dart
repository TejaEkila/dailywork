

class DataModel {
  int? id;
  late String date;
  late String title;
  late String description;
  late String comment;

  DataModel({this.id, required this.date, required this.title, required this.description,required this.comment});

  factory DataModel.fromMap(Map<String, dynamic> json) => DataModel(
    id: json["id"],
    date: json["date"],
    title: json["title"],
    description: json["description"],
    comment: json["comment"]
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "date": date,
    "title": title,
    "description": description,
    "comment":comment,
  };
}
