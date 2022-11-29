import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/auth/phone_auth.dart';
import 'package:task/data/local_storage/storage.dart';
import 'package:task/data/models/product_model.dart';
import 'package:task/data/models/user_item.dart';
import 'package:task/utils/constants.dart';

class HelperRepository {
  HelperRepository({required FirebaseFirestore fireStore}) : _fireStore = fireStore;

  final FirebaseFirestore _fireStore;

  Future<void> postUser({
    required Map<String, dynamic> userJson,
  }) async {
    try {
      var newUser = await _fireStore.collection("users").add(userJson);
      await _fireStore.collection("users").doc(newUser.id).update({"user_id": newUser.id});
    } catch (e) {
      throw Exception();
    }
  }

  Stream<List<UserItem>> getUsers() => _fireStore.collection('users').snapshots().map(
        (snapshot) => snapshot.docs.map((doc) => UserItem.fromJson(doc.data())).toList(),
      );

  Future<UserItem> getUsersById({required String docId}) async {
    var data = await _fireStore.collection('users').doc(docId).get();
    UserItem userItem = UserItem.fromJson(data.data() as Map<String, dynamic>);
    return userItem;
  }

  // SIGN IN WITH PHONE NUMBER
  Future<void> singInWithPhoneNumber({required String number, required BuildContext context}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+998$number',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        debugPrint('VERIFICATION FAILED: $e ');
      },
      codeSent: (String verificationId, int? resendToken) {
        debugPrint('VERIFICATION ID: $verificationId');
        PhoneAuth.verify = verificationId;

        Navigator.pushNamed(context, RouteNames.otp);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> otpVerification({required String code, required BuildContext context}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: PhoneAuth.verify,
        smsCode: code,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      await StorageRepository.putBool("isValid", true);

      Navigator.pushNamedAndRemoveUntil(context, RouteNames.home, (route) => false);
    } on FirebaseAuthException catch (e) {
      debugPrint("wrong otp: ${e.message}");
    }
  }






  Future<void> updateCard({required UserItem userItem, required String docId}) async {
    try {
      await _fireStore.collection("cards").doc(docId).update(userItem.toJson());
    } catch (e) {
      throw Exception();
    }
  }



  Stream<List<ProductModel>> getProduct() =>
      _fireStore.collection('product').snapshots().map(
            (snapshot) => snapshot.docs
            .map((doc) => ProductModel.fromJson(doc.data()))
            .toList(),
      );

  }





/*

 */
