import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:task/data/models/comment_model.dart';
import 'package:task/data/models/product_model.dart';
import 'package:task/data/repository/helper_repository.dart';

part 'product2_state.dart';

class Product2Cubit extends Cubit<Product2State> {
  Product2Cubit({required this.helperRepository})
      : super(Product2State(
          errorText: '',
          fields: {
            "product_id": "",
            "text": "",
            "user_id": "",
            "user_name": "",
            "comment_id": "",
          },
          comment: [],
          product: [],
          status: FormzStatus.pure,
          isAdded: false,
        ));

  final HelperRepository helperRepository;
  late StreamSubscription _subscriptionAll;

  Future<void> listenToProductComment({
    required String productId,
  }) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    _subscriptionAll = helperRepository.getProductComment(productId: productId).listen(
      (comment) {
        emit(
          state.copyWith(
            comment: comment,
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

  Future<void> addComment() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await helperRepository.postComment(
        userJson: state.fields,
      );
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure, errorText: error.toString()));
    }
  }

  void updateComment({
    required dynamic fieldValue,
    required String fieldKey,
  }) {
    var map = state.fields;
    map[fieldKey] = fieldValue;
    print(map);
    emit(state.copyWith(fields: map));
  }

  Future<void> listenToProduct() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    _subscriptionAll = helperRepository.getProduct().listen(
      (products) {
        emit(
          state.copyWith(
            product: products,
            status: FormzStatus.submissionSuccess,
          ),
        );
      },
      onError: (error) {
        emit(state.copyWith(errorText: error.toString(), status: FormzStatus.submissionFailure));
      },
    );
  }
}
