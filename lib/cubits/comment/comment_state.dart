part of 'comment_cubit.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class GetCommentInProgress extends CommentState {}

class GetCommentInSuccess extends CommentState {
  GetCommentInSuccess({required this.comment});

  final List<CommentModel> comment;
}

class GetCommentInFailure extends CommentState {
  final String errorText;

  GetCommentInFailure({required this.errorText});
}
