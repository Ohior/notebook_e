class NoteBook {
  int? id;
  final String title;
  final String detail;
  final String imagePath;
  final String createdTime;
  final String updatedTime;

  NoteBook(
      {this.id,
      required this.title,
      required this.detail,
      required this.imagePath,
      required this.createdTime,
      required this.updatedTime});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'detail': detail,
      'imagePath': imagePath,
      'createdTime': createdTime,
      'updatedTime': updatedTime
    };
  }

  @override
  String toString() {
    return '''NoteBook(
      'id' : $id,
      'title' : $title,
      'detail' : $detail,
      'imagePath' : $imagePath,
      'createdTime' : $createdTime,
      'updatedTime' : $updatedTime
    )''';
  }
}
