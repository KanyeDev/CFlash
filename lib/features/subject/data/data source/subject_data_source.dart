

import 'package:cflash/core/utility/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/subject_model.dart';

abstract class SubjectDataSource{
  Future<SubjectModel> addSubject(String title, String description, String lecturer, String image);
  Future<SubjectModel> viewSubject();
  Stream<List<SubjectModel>> viewAllSubject();
}

class SubjectDataSourceImpl implements SubjectDataSource {
  CollectionReference subject = FirebaseFirestore.instance.collection(
      "Subject");
  final _db = FirebaseFirestore.instance;

  final auth = FirebaseAuth.instance;

  //Add a new Subject
  @override
  Future<SubjectModel> addSubject(String title, String description,
      String lecturer, String image) async {
    List<String> data = [title, description, lecturer];
    String id = auth.currentUser!.uid;

    String docId = DateTime.now().microsecondsSinceEpoch.toString();

    DateTime date = DateTime.now();
    String currentDay = "${date.day}-${date.month}-${date.year}";

    try {
      subject.doc(docId).set({
        "title": title,
        "description": description,
        "lecturer": lecturer,
        "date" : currentDay,
        "uid": id,
        "image": image
      });
      Utility().toastMessage("Subject Added Successfully");
    } catch (err) {
      Utility().toastMessage(err.toString());
    }

    return SubjectModel.setData(data);
  }

  //view added subject
  @override
  Future<SubjectModel> viewSubject() async {
    String id = auth.currentUser!.uid;

    final snapshot = await _db.collection("Subject").where(_db
        .collection("Subject")
        .id, isEqualTo: id).get();
    final subjectData = snapshot.docs
        .map((e) => SubjectModel.fromSnapshot(e))
        .single;

    return subjectData;
  }

  @override
  Stream<List<SubjectModel>> viewAllSubject() {
    String id = auth.currentUser!.uid;

    return _db
        .collection("Subject")
        .where("uid", isEqualTo: id)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => SubjectModel.fromSnapshot(doc))
        .toList());
  }
}