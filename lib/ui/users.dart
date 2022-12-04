import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:task/cubits/user/user_cubit.dart';
import 'package:task/ui/card/widgets/custom_app_bar.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Users",),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          var st = state.status;
          print(" status >> ${st} ");

          if (st == FormzStatus.submissionInProgress) {
            print("progres user >>> ");
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (st == FormzStatus.submissionSuccess) {
            var users = state.users;
            return ListView(children:
            List.generate(users.length, (index) => Container(
              child: Column(children: [
                Text(users[index].userName)
              ],),
            )),);
          }
          return Center(child: Text("bo'shh"),);
        } ),
    );
  }
}
