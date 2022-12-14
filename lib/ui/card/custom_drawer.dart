import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/cubits/cards/cards_cubit.dart';
import 'package:task/cubits/user/user_cubit.dart';
import 'package:task/data/local_storage/storage.dart';
import 'package:task/ui/card/add_my_card.dart';
import 'package:task/ui/card/my_card.dart';
import 'package:task/utils/color.dart';
import 'package:task/utils/icons/icon.dart';
import 'package:task/utils/my_utils.dart';
import 'package:task/utils/style.dart';
import 'package:task/widgets/active_button.dart';
import 'widgets/drawer_item.dart';
// ignore: must_be_immutable
class CustomDrawer extends StatelessWidget {
   CustomDrawer({Key? key}) : super(key: key);

   User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Drawer(
            backgroundColor: MyColors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                                height: 70,
                                width: 70,
                                child: Image.asset(
                                  MyIcons.userImg[3],
                                  fit: BoxFit.cover,
                                ))),
                        const SizedBox(height: 8),
                        Text(
                          user?.displayName ?? 'user Name',
                          style: MyTextStyle.sfProSemibold.copyWith(fontSize: 20,color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "id: ${user?.uid ?? 'user id'}",
                          style: MyTextStyle.sfProSemibold.copyWith(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 5),

                        // USER EMAIL
                        Text(
                          // user.email ?? '@email',
                          user?.phoneNumber !=null? user!.phoneNumber.toString():"+9998 91 614 2616",
                          style: MyTextStyle.sfProSemibold,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            MyUtils.showSnackBar(context, "Jarayonda");
                            // Navigator.pushNamed(context, profileUpdatePage);
                          },
                          child: Text(
                            "edit profile",
                            style: MyTextStyle.sfProMedium.copyWith(fontSize: 16, color: MyColors.C_356899),
                          ),
                        ),
                        CustomDrawerItem(
                          title: "settings",
                          icon: Icons.settings,
                          itemColor: Theme.of(context).hintColor,
                          onPressed: () {
                            // Navigator.pushNamed(context, settingsPage);
                          },
                        ),

                        CustomDrawerItem(
                          title: "add card",
                          icon: Icons.add,
                          itemColor: Theme.of(context).hintColor,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookingPaymentScreen(),
                                ));
                          },
                        ),
                        CustomDrawerItem(
                          title: 'news',
                          itemColor: Theme.of(context).hintColor,
                          icon: Icons.notifications_none,
                          onPressed: () {
                            // Navigator.pushNamed(context, notificationPage);
                            // BlocProvider.of<NotificationCubit>(context).readSavedNews();
                          },
                        ),
                        CustomDrawerItem(
                          title: 'about',
                          itemColor: Theme.of(context).hintColor,
                          icon: Icons.info_outline,
                          onPressed: () {
                            // Navigator.pushNamed(context, aboutPage);
                          },
                        ),
                        CustomDrawerItem(
                          title: 'help',
                          itemColor: Theme.of(context).hintColor,
                          icon: Icons.help_outline,
                          onPressed: () {
                            // UrlLauncher.launchUrl(
                            //     Uri.parse("https://t.me/ishTopAdmin_bot"),
                            //     mode: LaunchMode.externalApplication);
                          },
                        ),
                        CustomDrawerItem(
                          title: "logout",
                          icon: Icons.logout_outlined,
                          itemColor: Colors.red,
                          onPressed: () async{
                            await StorageRepository.deleteBool("isValid");
                            Navigator.pop(context);
                          },
                        ),

                        const SizedBox(height: 15),
                        // const Expanded(child: SizedBox()),
                        // PREMIUM BUTTON
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: MediaQuery.of(context).padding.bottom),
                          child: ActiveButton(
                            buttonText: "My Cards",
                            onPressed: () {
                              Navigator.push(context,MaterialPageRoute(builder:  (context)=> MyCards()));
                              context.read<CardsCubit>().listenToUserCard(userId: user!.uid.toString());
                            },
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}

/*
 ListTile(

              ElevatedButton(
                  onPressed: () async {
                    await StorageRepository.deleteBool("isValid");
                    Navigator.pop(context);
                  },
                  child: Text("log out")),
 */
