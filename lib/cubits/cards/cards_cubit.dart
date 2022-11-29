import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/data/models/card_model.dart';
import 'package:task/data/repository/card_repository.dart';

part 'cards_state.dart';

class CardsCubit extends Cubit<CardsState> {
  CardsCubit({
    required this.cardsRepository,
  }) : super(CardsInitial());

  final CardsRepository cardsRepository;

  late StreamSubscription _subscription;

  List<CardModel> cards = [];

  Future<void> listenToTeachers() async {
    emit(GetCardsInProgress());
    _subscription = cardsRepository.getCards().listen(
          (items) {
        emit(GetCardsInSuccess(cards: items));
        cards = items;
      },
      onError: (error) {
        emit(GetCardsInFailure(errorText: error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
