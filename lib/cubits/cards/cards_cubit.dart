import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:task/data/models/card_model.dart';
import 'package:task/data/repository/card_repository.dart';

part 'cards_state.dart';

class CardsCubit extends Cubit<CardsState> {
  CardsCubit({required this.cardsRepository})
      : super(
          CardsState(
            errorText: '',
            status: FormzStatus.pure,
            isAdded: false,
            cards: [],
            fields: {
              "card_id": "",
              "card_num": "",
              "card_salary": "",
              "holder_name": "",
              "user_id": "",
              "expiry_data":"",
            },
          ),
        );

  final CardsRepository cardsRepository;
  late StreamSubscription _subscriptionAll;


  Future<void> listenToUserCard({
    required String userId,
  }) async {
    debugPrint("User Id listeneTo User ichi>> $userId");
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    _subscriptionAll = cardsRepository.getCardByUserId(userId: userId).listen(
          (cards) {
            debugPrint(">>>>>>>>>>>>>>>${cards[0].cardNum.toString()}>>>>>>>>");
        emit(
          state.copyWith(
            cards: cards,
            status: FormzStatus.submissionSuccess,
          ),
        );
      },
      onError: (error) {
        emit(
          state.copyWith(
            errorText: error.toString(),

            status: FormzStatus.submissionFailure,
          ),
        );
      },
    );
  }

  Future<void> addCard() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await cardsRepository.postCard(
        cardJson: state.fields,
       );
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure, errorText: error.toString()));
    }
  }


  void updateCard({
    required dynamic fieldValue,
    required String fieldKey,
  }) {
    var map = state.fields;
    map[fieldKey] = fieldValue;
    debugPrint(map.toString());
    emit(state.copyWith(fields: map));
  }


  void emptyFields() {
    emit(
      state.copyWith(
        isAdded: true,
        status: FormzStatus.submissionSuccess,
        fields: {
          "card_id": "",
          "card_num": "",
          "card_salary": "",
          "holder_name": "",
          "user_id": "",
          "expiry_data":"",
        },
      ),
    );
  }

}
