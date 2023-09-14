// ignore_for_file: void_checks
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ys/Network/local/cache_helper.dart';
import 'package:ys/Screens/auth/RegisterData/RegisterScreen.dart';
import 'package:ys/constants.dart';
import 'package:ys/layout/HomeScreen.dart';
import 'package:ys/models/loginModel.dart';
import 'package:ys/shard/common/myColors.dart';
import 'package:ys/shard/cubits/login/login_auth_cubit.dart';

import '../../../shard/common/widgets.dart';

class SignInScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  bool remember = false;

  var phoneCont = TextEditingController();
  var passCont = TextEditingController();

  String? mytoken;
 late UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginAuthCubit, LoginAuthState>(
      listener: (context, state) {
        if (state is LoginAuthSuccess) {
          if (state.userModel.status!) {
            CacheHelper.SaveData(key: 'id', value: state.userModel.data!.userId,).then((value) {
              CacheHelper.SaveData(key: 'username', value: state.userModel.data!.username);
              navigateAndFinish(context, HomeScreen());
            });
          } else {
            final snackBar = SnackBar(
              backgroundColor:MyColors.green,
              content: Text('رقم التلفون أو كلمة السر خطأ'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Directionality(
              textDirection: TextDirection.rtl,
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Container(
                            height: 200,
                            width: 200,
                            child: Image.asset(
                              "assets/images/yosrlogo.jpg",
                              height: 299,
                              width: 29,
                            ),
                          ),

                          SizedBox(height: 10),
                          Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Column(
                                children: [
                                  buildEmailFormField(context,
                                      phoneController: phoneCont),
                                  buildPasswordFormField(context,
                                      passController: passCont),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: remember,
                                        activeColor: Colors.grey,
                                        onChanged: (value) {
                                          /*   setState(() {
                                      remember = value;
                                    });*/
                                        },
                                      ),
                                      Text("تذكر تسجيل الدخول."),
                                    ],
                                  ),
                                  // FormError(errors: errors),
                                  SizedBox(height: 10),
                                  ButtonYOSR(
                                    function: () {
                                      // _firebaseMessaging.getToken().then((String token) {
                                      //    UsersCubit.get(context).loginIn(
                                      //      phone: phoneCont.text,
                                      //      passwords: passCont.text,
                                      //      mytoken: token,
                                      //    );
                                      //
                                      //  });
                                      LoginAuthCubit.get(context).loginIn(
                                        phone: phoneCont.text,
                                        passwords: passCont.text,
                                      );
                                    },
                                    text: 'تسجيل الدخول',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          NoAccountText(context),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }
  TextFormField buildPasswordFormField(BuildContext context,
      {required TextEditingController passController}) {
    return TextFormField(
      controller: passController,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          LoginAuthCubit.get(context).removeError(error: kPassNullError);
          // } else if (value.length >=5) {
          //   UsersCubit.get(context).removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          LoginAuthCubit.get(context).addErorr(error: kPassNullError);
          return "ادخل كلمة السر";
          // } else if (value.length <=5) {
          //   UsersCubit.get(context).addErorr(error: kShortPassError);
          //   return "كلمة السر قصيرة";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "كلمة السر",
        hintText: "ادخل كلمة السر",
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildEmailFormField(BuildContext context,
      {required TextEditingController phoneController}) {
    return TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          LoginAuthCubit.get(context).removeError(error: kPassNullError);
        } else if (value.length >= 6) {
          LoginAuthCubit.get(context).removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          LoginAuthCubit.get(context).addErorr(error: kPassNullError);
          return "ادخل رقم الجوال";
        } else if (value.length > 9 || value.length < 9) {
          LoginAuthCubit.get(context).addErorr(error: kShortPassError);
          return "رقم الهاتف خطأ";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "رقم الجوال",
        hintText: "ادخل رقم الجوال",
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: Icon(Icons.phone_android),
      ),
    );
  }

  Widget NoAccountText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "ليس لديك حساب؟ ",
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: () {
            navigateTo(context, RegisterDataScreens());
          },
          child: Text(
            "انشاء حساب",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }


}
class KeyboardUtil {
  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
