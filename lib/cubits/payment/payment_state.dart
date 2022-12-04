import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/data/models/payment_model.dart';
import 'package:task/service/payment_service.dart';

part 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PaymentInitialState extends PaymentState {
  const PaymentInitialState();
}

class PaymentLoadingState extends PaymentState {
  const PaymentLoadingState();
}

class PaymentSuccessState extends PaymentState {
  final PaymentModel data;
  const PaymentSuccessState({required this.data});
}

class PaymentErrorState extends PaymentState {
  final String error;
  const PaymentErrorState(this.error);
}
