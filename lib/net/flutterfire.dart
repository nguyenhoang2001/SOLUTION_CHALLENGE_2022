import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:solution_challenge_2022/commons/utils.dart';

Future<bool> signin(String email, String password) async{
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch(e){
    if(e.code == "ERROR_INVALID_EMAIL") print("error");
    return false;
  }

}
Future <bool> register(String email, String password) async{
  try{
    // Firebase.initializeApp();
    print('came here');
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    print('came here finish');
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return true;
  }
}
Future <bool> saveToFirebase(String email,String name,String dateofbirth, String phonenumber, String job) async {
  try{
    String uid =Utils.getRandomString(8) + Random().nextInt(500).toString();
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(email).collection('Profile').doc(uid);
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);
      if(!snapshot.exists){
        documentReference.set({
          "Email": email,
          "Name":name,
          "Date of birth":dateofbirth,
          "Phone number":phonenumber,
          "Job":job
        });
        return true;
      }
      return true;
    });
  } catch(e){
    return false;
  }
  return true;
}

