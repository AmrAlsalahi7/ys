import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ys/Network/local/cache_helper.dart';
import 'package:ys/Screens/Bank_account/register_bank/Bank_data.dart';
import 'package:ys/layout/HomeScreen.dart';
import 'package:ys/models/postmodel.dart';
import 'package:ys/shard/common/myColors.dart';
import 'package:ys/shard/common/widgets.dart';
import 'package:ys/shard/cubits/bank_account/login_bank_cubit/login_bank_cubit.dart';

class LoginBankAccount extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  bool remember = false;

  var accountController = TextEditingController();
  var passCont = TextEditingController();

 late DataPost dataPost;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBankCubit(),
      child: BlocConsumer<LoginBankCubit, LoginBankState>(
        listener: (context, state) {
          if(state is LoginBankSuccess){
            if(state.loginBankModel.status){
              CacheHelper.SaveData(key: 'bk_id', value:state.loginBankModel.data.bkId).then((value) {
                if (value) {
                  navigateAndFinish(context,HomeScreen());
                }
              });
            }else{
              final snackBar = SnackBar(
                content: Text(state.loginBankModel.message),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading:IconButton(onPressed:(){
                Navigator.pop(context);
              }, icon:Icon(Icons.arrow_back_ios_sharp,color: MyColors.white,),),
            ),
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
                                        accountController: accountController),
                                    buildPasswordFormField(context,
                                        passController: passCont),

                                    // FormError(errors: errors),
                                    SizedBox(height: 10),

                                    ConditionalBuilder(
                                      condition: 1 > 0,
                                      builder: (context) => ButtonYOSR(
                                        function: () {
                                         late var token = CacheHelper.GetData(key: 'id');

                                          // _firebaseMessaging.getToken().then((String token) {
                                          //    UsersCubit.get(context).loginIn(
                                          //      phone: phoneCont.text,
                                          //      passwords: passCont.text,
                                          //      mytoken: token,
                                          //    );
                                          //
                                          //  });
                                          LoginBankCubit.get(context).loginBank(
                                              user_id: token,
                                              account: accountController.text,
                                              passwords: passCont.text);
                                        },
                                        text: 'تسجيل الحساب البنكي',
                                      ),
                                      fallback: (context) => Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            NoAccountText(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }

  TextFormField buildPasswordFormField(BuildContext context,
      {required TextEditingController passController}) {
    return TextFormField(
      controller: passController,
      obscureText: true,
      onChanged: (value) {
        if (value.isNotEmpty) {
          // LoginAuthCubit.get(context).removeError(error: kPassNullError);
          // } else if (value.length >=5) {
          //   UsersCubit.get(context).removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          // LoginAuthCubit.get(context).addErorr(error: kPassNullError);
          return "ادخل كلمة السر";
          // } else if (value.length <=5) {
          //   UsersCubit.get(context).addErorr(error: kShortPassError);
          //   return "كلمة السر قصيرة";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "كلمة السر لحسابك البنكي",
        hintText: "كلمة السر لحسابك البنكي",
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildEmailFormField(BuildContext context,
      {required TextEditingController accountController}) {
    return TextFormField(
      controller: accountController,
      keyboardType: TextInputType.number,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          // LoginAuthCubit.get(context).removeError(error: kPassNullError);
        } else if (value.length >= 6) {
          // LoginAuthCubit.get(context).removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          // LoginAuthCubit.get(context).addErorr(error: kPassNullError);
          return "ادخل رقم الجوال";
        } else if (value.length > 9 || value.length < 9) {
          // LoginAuthCubit.get(context).addErorr(error: kShortPassError);
          return "رقم الهاتف خطأ";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "رقم حسابك البنكي",
        hintText: "رقم حسابك البنكي",
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
          "",
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: () {
            navigateTo(context, BankData());
          },
          child: Text(
            "انشاء حساب بنكي جديد ؟",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
