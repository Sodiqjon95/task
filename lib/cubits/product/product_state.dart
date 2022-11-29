part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class GetProductInProgress extends ProductState {}

class GetProductInSuccess extends ProductState {
  GetProductInSuccess({required this.product});

  final List<ProductModel> product;
}

class GetProductInFailure extends ProductState {
  final String errorText;

  GetProductInFailure({required this.errorText});
}