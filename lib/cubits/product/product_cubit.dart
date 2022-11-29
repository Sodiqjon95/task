import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/data/models/product_model.dart';
import 'package:task/data/repository/helper_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.helperRepository,}) : super(ProductInitial());

  final HelperRepository helperRepository;

  late StreamSubscription _subscription;

  List<ProductModel> product = [];

  Future<void> listenToProduct() async {
    emit(GetProductInProgress());
    _subscription = helperRepository.getProduct().listen(
          (items) {
        emit(GetProductInSuccess(product: items));
        product = items;
      },
      onError: (error) {
        emit(GetProductInFailure(errorText: error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
