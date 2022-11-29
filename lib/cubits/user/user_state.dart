part of 'user_cubit.dart';

class UserState extends Equatable {
  const UserState({
    required this.users,
    required this.isAdded,
    required this.allUsers,
    required this.errorText,
    required this.fields,
    required this.status,

});

  final FormzStatus status;
  final List<UserItem> users;
  final List<UserItem> allUsers;
  final Map<String, dynamic> fields;
  final String errorText;
  final bool isAdded;

  UserState copyWith({
    FormzStatus? status,
    List<UserItem>? users,
    List<UserItem>? allUsers,
    String? errorText,
    Map<String, dynamic>? fields,
    bool? isAdded,
  }) =>
      UserState(
        status: status ?? this.status,
        users: users ?? this.users,
        allUsers: allUsers ?? this.allUsers,
        errorText: errorText ?? this.errorText,
        fields: fields ?? this.fields,
        isAdded: isAdded ?? this.isAdded,
      );

  @override
  List<Object> get props => [
    status,
    fields,
    errorText,
    allUsers,
    isAdded,
    users,
  ];
}
