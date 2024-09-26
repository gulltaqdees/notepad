
class NotesModel {
  final int? id;
  final String title;
  final String description;
  final String color;
  NotesModel(
      {this.id,
      required this.title,
      required this.description,
      required this.color});

  //serialization- convert dart obj into map - for storing note in DB
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'color': color
    };
  }

  //deserialization-converting map into dart obj - for getting notes from DB
  NotesModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        description = res['description'],
        color = res['color'];
}
