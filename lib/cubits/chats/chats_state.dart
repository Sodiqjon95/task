part of 'chats_cubit.dart';

class ChatsState extends Equatable {
  const ChatsState({
    required this.errorText,
    required this.status,
    required this.fields,
    required this.isAdded,
    required this.chats,
  });

  final FormzStatus status;
  final List<ChatsModel> chats;
  final Map<String, dynamic> fields;
  final String errorText;
  final bool isAdded;


  ChatsState copyWith({
    FormzStatus? status,
    List<ChatsModel>? chats,
    String? errorText,
    Map<String, dynamic>? fields,
    bool? isAdded,
  }) =>
      ChatsState(
        status: status ?? this.status,
        chats: chats ?? this.chats,
        errorText: errorText ?? this.errorText,
        fields: fields ?? this.fields,
        isAdded: isAdded ?? this.isAdded,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [status, fields, errorText, isAdded, chats];
}
