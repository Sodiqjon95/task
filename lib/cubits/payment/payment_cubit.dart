part of 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(const PaymentInitialState());



  // Transfer money method
  Future<void> transferMoney({required String receiver, required String amount, required String sender}) async {
    await Future.delayed(const Duration(seconds: 1));
    emit(const PaymentLoadingState());
    try{

      PaymentModel data =  await PaymentService.transferMoney(receiverCardNumber: receiver ,
          amount:amount, senderCardNumber: sender);
      emit(PaymentSuccessState(data: data));

    } catch (e){
      emit(PaymentErrorState(e.toString()));
    }

  }
}
