import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:task/data/models/user_item.dart';
import 'package:task/data/repository/helper_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.helperRepository})
      : super(const UserState(
          isAdded: false,
          allUsers: [],
          errorText: '',
          status: FormzStatus.pure,
          users: [],
          fields: {
            "phone_number": "",
            "user_auth": "",
            "user_id": "",
            "user_name": "",
          },
        ));

  final HelperRepository helperRepository;
  // late StreamSubscription _subscriptionAll;

  Future<void> singInWithPhoneNumber({required String number, required BuildContext context}) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await helperRepository.singInWithPhoneNumber(number: number, context: context);

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on FirebaseAuthException catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure, errorText: error.message));
    }
  }

  Future<void> otpVerification({required String code, required BuildContext context}) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await helperRepository.otpVerification(code: code, context: context);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
      var uid = FirebaseAuth.instance.currentUser!.uid;
      var phoneNumber = FirebaseAuth.instance.currentUser!.phoneNumber!;
      await addUser(user: UserItem(userId: uid, phoneNumber: phoneNumber, userAuth: '', userName: 'User Name'));
    } on FirebaseAuthException catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure, errorText: error.message));
    }
  }

  Future<void> addUser({required UserItem user}) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await helperRepository.postUser(
        userJson: user.toJson(),
      );
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure, errorText: error.toString()));
    }
  }

  void updateCurrentItem({
    required dynamic fieldValue,
    required String fieldKey,
  }) {
    var map = state.fields;
    map[fieldKey] = fieldValue;
    debugPrint("MAP DATA:${map}");
    emit(state.copyWith(fields: map));
  }

}
