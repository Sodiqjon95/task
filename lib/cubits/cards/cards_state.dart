part of 'cards_cubit.dart';

 class CardsState extends Equatable {
   const CardsState({
     required this.status,
     required this.errorText,
     required this.fields,
     required this.isAdded,
     required this.cards,
   });


   final FormzStatus status;
   final List<CardModel> cards;
   final Map<String, dynamic> fields;
   final String errorText;
   final bool isAdded;

   CardsState copyWith({
     FormzStatus? status,
     List<CardModel>? cards,
     String? errorText,
     Map<String, dynamic>? fields,
     bool? isAdded,
   }) =>
       CardsState(
         status: status ?? this.status,
         cards: cards ?? this.cards,
         errorText: errorText ?? this.errorText,
         fields: fields ?? this.fields,
         isAdded: isAdded ?? this.isAdded,
       );

   @override
   List<Object> get props =>
       [
         status,
         fields,
         errorText,
         isAdded,
         cards
       ];
 }