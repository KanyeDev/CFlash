import 'package:cflash/core/utility/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/sign_up_model.dart';

abstract class SignUpDataSource {
  Future<SignUpModel> createUser(String uid, String userName, String email);

  Future<SignUpModel> registerUser(
      String email, String password, String userName);
}

class SignupDataSourceImpl implements SignUpDataSource {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<SignUpModel> createUser(
      String uid, String userName, String email) async {
    users
        .doc(uid)
        .set({"userId": uid, "username": userName, "email": email}).onError(
            (error, stackTrace) => Utility().toastMessage(error.toString()));
    List<String> data = [uid, email, '', userName];
    return SignUpModel.setData(data);
  }

  @override
  Future<SignUpModel> registerUser(
      String email, String password, String userName) async {
    late List<String> data;
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      data = [result.user!.uid, email, password, userName];
      createUser(result.user!.uid, userName, email);
    } catch (e) {
      Utility().toastMessage(e.toString());
    }

    return SignUpModel.setData(data);
  }
}
