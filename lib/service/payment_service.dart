import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:task/data/models/payment_model.dart';

class PaymentService {


  static Future<PaymentModel> transferMoney({
    required String receiverCardNumber,
    required String amount,
    required String senderCardNumber,
  }) async {
    try {
      Response response = await Dio().post("http://192.168.5.52:4000/payment", data: {
        "reciever_card_number": receiverCardNumber,
        "amount": amount,
        "sender_card_number": senderCardNumber
      });
      await Future.delayed(const Duration(seconds: 1));
      if (response.statusCode == HttpStatus.ok) {
        return PaymentModel.fromJson(response.data);
      } else {
        throw Exception();
      }
    } catch (e) {
      debugPrint("CATCH ERROR $e");
      throw Exception(e);
    }
  }
}
