import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/data/models/card_model.dart';

class CardsRepository {
  final FirebaseFirestore _fireStore;

  CardsRepository({required FirebaseFirestore fireStore}) : _fireStore = fireStore;

  Future<void> postCard({
    required Map<String, dynamic> cardJson,
  }) async {
    try {
      var newCard = await _fireStore.collection("cards").add(cardJson);
      await _fireStore.collection("cards").doc(newCard.id).update({"card_id": newCard.id});
    } catch (e) {
      throw Exception();
    }
  }

  Future<void> updateCard({required CardModel cardModel, required String docId}) async {
    try {
      await _fireStore.collection("cards").doc(docId).update(cardModel.toJson());
    } catch (e) {
      throw Exception();
    }
  }
  Stream<List<CardModel>> getCards() =>
      _fireStore.collection('cards').snapshots().map(
            (snapshot) => snapshot.docs
            .map((doc) => CardModel.fromJson(doc.data()))
            .toList(),
      );

  Stream<List<CardModel>> getCardByUserId(
          {required String userId}) =>
      _fireStore
          .collection('cards')
          .where("user_id", isEqualTo: userId)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map((doc) => CardModel.fromJson(doc.data()))
                .toList(),
          );

  Future<void> deleteCard({
    required String docId,
  }) async {
    try {
      await _fireStore.collection("cards").doc(docId).delete();
    } catch (e) {
      throw Exception();
    }
  }
}
