import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ys/Network/local/cache_helper.dart';
import 'package:ys/Screens/auth/loginScreen/sign_in_screen.dart';
import 'package:ys/shard/cubits/RegisterData/RegisterState.dart';
import 'package:ys/shard/cubits/RegisterData/Register_Cubit.dart';

import '../../../shard/common/widgets.dart';

class RegisterDataScreens extends StatelessWidget {
  final phoneNumber;

  RegisterDataScreens({Key? key, this.phoneNumber}) : super(key: key);
  static final GlobalKey<FormState> _fromkey = GlobalKey();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();

 late var phon = CacheHelper.sharedpref.getString("phone");

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterDataAuthCubit, RegisterDataAuthStates>(
        listener: (context, state) {
      if (state is RegisterUserStatesSuccess) {
        if (state.register.status) {
          navigateTo(context, SignInScreen());
        } else {
          final snackBar = SnackBar(
            content: Text(state.register.message),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          navigateTo(context, SignInScreen());
        }
      }

    },
        builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        height: 200,
                        width: 200,
                        child: Image.asset(
                          "assets/images/yosrlogo.jpg",
                          height: 299,
                          width: 299,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "انشاء حساب جديد",
                      ),
                      SizedBox(height: 10),
                      Form(
                        key: _fromkey,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Text('رقم هاتفك : ${phon}'),
                            SizedBox(height: 20),
                            TextBoxYOSR(
                              lable: 'الأسم الرباعي',
                              prefixicon: Icons.person_outline_outlined,
                              textcontroller: nameController,
                            ),
                            SizedBox(height: 20),
                            TextBoxYOSR(
                              lable: 'كلمة السر',
                              prefixicon: Icons.lock,
                              textcontroller: passwordController,
                            ),
                            SizedBox(height: 40),
                            ButtonYOSR(
                              text: "تسجيل",
                              function: () {
                                RegisterDataAuthCubit.get(context).signUp(
                                  username: nameController.text,
                                  phone: phoneNumber,
                                  password: passwordController.text,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
