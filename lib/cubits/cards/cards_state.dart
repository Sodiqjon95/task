part of 'cards_cubit.dart';

@immutable
abstract class CardsState {}

class CardsInitial extends CardsState {}


class GetCardsInProgress extends CardsState {}

class GetCardsInSuccess extends CardsState {
  GetCardsInSuccess({required this.cards});

  final List<CardModel> cards;
}

class GetCardsInFailure extends CardsState {
  final String errorText;

  GetCardsInFailure({required this.errorText});
}
