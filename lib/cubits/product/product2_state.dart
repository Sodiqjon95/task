part of 'product2_cubit.dart';

 class Product2State extends Equatable {
  const Product2State({
    required this.status,
    required this.errorText,
    required this.fields,
    required this.isAdded,
    required this.comment,
    required this.product,
});

  final FormzStatus status;
  final List<CommentModel> comment;
  final List<ProductModel> product;
  final Map<String, dynamic> fields;
  final String errorText;
  final bool isAdded;

  Product2State copyWith({
    FormzStatus? status,
    List<CommentModel>? comment,
    List<ProductModel>? product,
    String? errorText,
    Map<String, dynamic>? fields,
    bool? isAdded,
  }) =>
      Product2State(
        status: status ?? this.status,
        comment: comment ?? this.comment,
        product: product ?? this.product,
        errorText: errorText ?? this.errorText,
        fields: fields ?? this.fields,
        isAdded: isAdded ?? this.isAdded,
      );
  @override
  List<Object?> get props => [
    status,
    fields,
    errorText,
    comment,
    isAdded,
    product
  ];
}

