import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ys/Network/local/cache_helper.dart';
import 'package:ys/Screens/auth/otp_screens/phoneAuthScreen.dart';
import 'package:ys/firebase_options.dart';
import 'package:ys/layout/HomeScreen.dart';
import 'package:ys/shard/cubits/RegisterData/Register_Cubit.dart';
import 'package:ys/shard/cubits/auth-phone/PhoneAuthcubit.dart';
import 'package:ys/shard/cubits/bank_account/bank_account_cubit.dart';
import 'package:ys/shard/cubits/homeCubit/cubit.dart';
import 'package:ys/shard/cubits/login/login_auth_cubit.dart';
import 'package:ys/shard/cubits/postscubit/posts_foregat/foregat_cubit.dart';
import 'package:ys/shard/cubits/postscubit/posts_projects/project_cubit.dart';
import 'package:ys/shard/them.dart';

import 'Network/remot/dio_helper.dart';
import 'Screens/auth/loginScreen/sign_in_screen.dart';
void main () async{
  WidgetsFlutterBinding.ensureInitialized(); //tp make sure for flutter code is ready to use
  // await Firebase.initializeApp(
  //   // options: DefaultFirebaseOptions.currentPlatform,
  //   // name:"yosrtest"
  // );
  await CacheHelper.CacheInit();
  await DioHelper.init();
  Widget widget;
  late var token = CacheHelper.GetData(key: 'id') ?? "";
  String? bk_token = CacheHelper.GetData(key: 'bk_id') ?? "";

  print(bk_token);
  print(token);
  widget = HomeScreen();

  // if (token != '') {
  //   widget = HomeScreen();
  // }
  // else if {
  //    widget = phoneScreen();
  //  }
  // else
  // {
  //   widget = phoneScreen();
  // }

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  Widget? startWidget;

  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => HomeCubit(),
          ),

          BlocProvider(
              create: (context) => ProjectCubit()..showPostsProject()..countPerson()..countMoney()..countDeposit()),
          BlocProvider(
            create: (BuildContext context) => RegisterDataAuthCubit(),
          ),

          BlocProvider(
            create: (BuildContext context) => AuthCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => BankAccountCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => LoginAuthCubit(),
          ),
          BlocProvider(
            create: (context) => ForegatCubit()..showPostsForegat(),),
        ],
        child: MaterialApp(
          theme: ligthTheme,
          debugShowCheckedModeBanner: false,
          home: startWidget,
        ));
  }
}

