import 'package:cflash/features/subject/domain/entity/subject.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectModel extends Subject {
  const SubjectModel(
      {required String title,
      required String description,
      required String lecturer})
      : super(title: title, description: description, lecturer: lecturer);

  factory SubjectModel.setData(List<String> data) {
    return SubjectModel(
        title: data[0], description: data[1], lecturer: data[2]);
  }

  factory SubjectModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;

    return SubjectModel(
        title: data['title'],
        description: data['description'],
        lecturer: data['lecturer']);
  }

  Map<String, dynamic> toJson() {
    return {"title": title, "description": description, "lecturer": lecturer};
  }
}
