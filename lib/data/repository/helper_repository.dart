import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/auth/phone_auth.dart';
import 'package:task/data/local_storage/storage.dart';
import 'package:task/data/models/chats_model.dart';
import 'package:task/data/models/comment_model.dart';
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
      _fireStore.collection("users").doc(newUser.id);
    } catch (e) {
      throw Exception();
    }
  }

  Stream<List<UserItem>> getUsers() => _fireStore.collection('users').snapshots().map(
        (snapshot) {
          debugPrint(" users>>>>>>>> ${snapshot.docs.map((doc) => UserItem.fromJson(doc.data())).toList()}");
          return snapshot.docs.map((doc) => UserItem.fromJson(doc.data())).toList();
        },
      );

  Future<UserItem> getUsersById({required String docId}) async {
    var data = await _fireStore.collection('users').doc(docId).get();
    UserItem userItem = UserItem.fromJson(data.data() as Map<String, dynamic>);
    return userItem;
  }

  // ---------------------------------COMMENT---------------------------------------------
  Future<void> postComment({
    required Map<String, dynamic> userJson,
  }) async {
    try {
      var newComment = await _fireStore.collection("comment").add(userJson);
      print(newComment);
      await _fireStore.collection("comment").doc(newComment.id).update({"comment_id": newComment.id});
    } catch (e) {
      throw Exception();
    }
  }

  Stream<List<CommentModel>> getComment() => _fireStore.collection('comment').snapshots().map(
        (snapshot) => snapshot.docs.map((doc) => CommentModel.fromJson(doc.data())).toList(),
      );

  Future<CommentModel> getCommentById({required String docId}) async {
    var data = await _fireStore.collection('comment').doc(docId).get();
    CommentModel commentModel = CommentModel.fromJson(data.data() as Map<String, dynamic>);
    return commentModel;
  }

  Stream<List<CommentModel>> getProductComment({required String productId}) {
    print("get product ichii ${productId}");
    return _fireStore.collection('comment').where("product_id", isEqualTo: productId).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => CommentModel.fromJson(doc.data())).toList(),
        );
  }

// -------------------------------------SIGN IN WITH PHONE NUMBER---------------------------------------------------------------------

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

//----------------------------------------PRODUCT-------------------------------------------------------------

  Stream<List<ProductModel>> getProduct() => _fireStore.collection('product').snapshots().map(
        (snapshot) => snapshot.docs.map((doc) => ProductModel.fromJson(doc.data())).toList(),
      );

  //-------------------------------------CHATS----------------------------------------------------

  Stream<List<ChatsModel>> getTwoUsersConversation() =>
      _fireStore.collection('chats').orderBy("creat_at").
      // .where("sender_id", isEqualTo: senderId)
      // .where("receiver_id", isEqualTo: receiverId).
      snapshots().map(
        (snapshot) => snapshot.docs.map((doc) => ChatsModel.fromJson(doc.data())).toList(),
      );

  Future<void> postChat({
    required Map<String, dynamic> chatJson,
  }) async {
    try {
      var newChat = await _fireStore.collection("chats").add(chatJson);
      await _fireStore.collection("chats").doc(newChat.id).update({"chat_id": newChat.id});
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> updateChat({required ChatsModel chatsModel, required String docId}) async {
    try {
      await _fireStore.collection("chats").doc(docId).update(chatsModel.toJson());
    } catch (e) {
      throw Exception();
    }
  }

  Stream<List<ChatsModel>> getChats() => _fireStore.collection('chats').snapshots().map(
        (snapshot) => snapshot.docs.map((doc) => ChatsModel.fromJson(doc.data())).toList(),
      );
//--------------------------------------CHAT------------------------------------------------

}
