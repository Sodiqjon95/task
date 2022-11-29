import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/cubits/product/product_cubit.dart';
import 'package:task/cubits/user/user_cubit.dart';
import 'package:task/data/repository/helper_repository.dart';
import 'package:task/router/router.dart';
import 'package:task/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        splitScreenMode: true,
        minTextAdapt: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => UserCubit(
                  helperRepository: HelperRepository(fireStore: FirebaseFirestore.instance),
                ),
              ),
              BlocProvider(
                create: (context) => ProductCubit(
                  helperRepository: HelperRepository(fireStore: FirebaseFirestore.instance),
                )..listenToProduct(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              onGenerateRoute: MyRouter.generateRoute,
              initialRoute: RouteNames.splash,
            ),
          );
        });
  }
}
