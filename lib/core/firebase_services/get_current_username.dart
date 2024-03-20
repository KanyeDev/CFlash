

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;



Future<String> getUserName() async{
  try{

    User? userID = auth.currentUser;

    final DocumentReference ref =
    FirebaseFirestore.instance.collection("users").doc(userID!.uid);

    DocumentSnapshot snapshot = await ref.get();

    // Check if the document exists
    if (snapshot.exists) {
      // Get the data from the document
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // Access specific fields from the data
      var name = data['username'];

      // Do something with the item
      return name;
    } else {
      return 'User';
    }

  }catch(e){
    return "User";
  }

}



final FirebaseAuth _auth = FirebaseAuth.instance;
User? getCurrentUser(){
  return _auth.currentUser;
}
