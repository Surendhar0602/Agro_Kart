import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firebaseservices{
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String getuserId(){

    return _firebaseAuth.currentUser.uid;

  }

  final CollectionReference productID = FirebaseFirestore.instance.collection("Products");

  final CollectionReference userID = FirebaseFirestore.instance.collection("users");


}
