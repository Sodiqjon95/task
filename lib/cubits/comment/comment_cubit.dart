import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/data/models/comment_model.dart';
import 'package:task/data/repository/helper_repository.dart';
part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit({required this.helperRepository}) : super(CommentInitial());

  final HelperRepository helperRepository;
  late StreamSubscription _subscription;
  List<CommentModel> comment = [];

  Future<void> listenToComment() async {
    emit(GetCommentInProgress());
    _subscription = helperRepository.getComment().listen(
      (items) {
        emit(GetCommentInSuccess(comment: items));
        comment = items;
      },
      onError: (error) {
        emit(GetCommentInFailure(errorText: error.toString()));
      },
    );
  }


  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
