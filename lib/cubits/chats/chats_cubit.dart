import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:task/data/models/chats_model.dart';
import 'package:task/data/repository/helper_repository.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit({required this.helperRepository})
      : super(ChatsState(
          errorText: '',
          status: FormzStatus.pure,
          fields: {
            "text": "",
            "creat_at": "",
            "chat_id": "",
            "receiver_id": "",
            "sender_id": "",
          },
          isAdded: false,
          chats: [],
        ));

  final HelperRepository helperRepository;
  late StreamSubscription _subscriptionAll;
  List<ChatsModel> chat = [];

  Future<void> getTwoUsersConversation({
    required String senderId,
    required String receiverId,
  }) async {
    //chat yuqmi
    //bor ishlatingchi
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    _subscriptionAll = helperRepository.getTwoUsersConversation().listen((chats) {
      chat.clear();
      for (int i = 0; i < chats.length; i++) {
        if ((chats[i].senderId == receiverId || chats[i].receiverId == senderId)) {
          chat.add(chats[i]);
        }else{
          print("elsga kirdi");
        }
      }
      emit(state.copyWith(
        chats: chat,
        status: FormzStatus.submissionSuccess,
      ));
    }, onError: (error) {
      emit(
        state.copyWith(
          errorText: error.toString(),
          status: FormzStatus.submissionFailure,
        ),
      );
    });
  }


  Future<void> addChat() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await helperRepository.postChat(
        chatJson: state.fields,
      );
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure, errorText: error.toString()));
    }
  }

  void updateChat({
    required dynamic fieldValue,
    required String fieldKey,
  }) {
    var chat = state.fields;
    chat[fieldKey] = fieldValue;
    debugPrint(chat.toString());
    emit(state.copyWith(fields: chat));
  }

}
