import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ys/Network/local/cache_helper.dart';
import 'package:ys/Screens/Bank_account/display/display_account.dart';
import 'package:ys/Screens/Bank_account/login_bank_account/login_bank.dart';
import 'package:ys/shard/common/myColors.dart';
import 'package:ys/shard/common/widgets.dart';
import 'package:ys/shard/cubits/bank_account/bank_account_cubit.dart';


class BankData extends StatelessWidget {
  var fNameControler = TextEditingController();
  var emailControler = TextEditingController();
  var userAccountControler = TextEditingController();
  var passControler = TextEditingController();
  var tokens = CacheHelper.GetData(key: 'id');

  static final GlobalKey<FormState> _BankFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
   var  token = CacheHelper.GetData(key: 'id');
    // String bk_token = CacheHelper.GetData(key: 'bk_id');

    return BlocConsumer<BankAccountCubit, BankAccountState>(
        listener: (context, state) {
      if (state is BankAccountSuccess) {
        if (state.bankAccountModel.status!)
        {
          CacheHelper.SaveData(key: 'bank_data', value: true).then((value) {
            if (value) {
              navigateAndFinish(context, DisplayAccount(token: tokens));
            }else{
              print('dsds');
            }
          });
        }

        else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            headerAnimationLoop: false,
            animType: AnimType.rightSlide,
            title: 'الحساب موجود',
            desc: 'قم بتسجيل الدخول لحسابك',
            btnOkOnPress: () {
              CacheHelper.SaveData(key: 'bank_data', value: true).then((value) {
                if (value) {
                  navigateTo(context, LoginBankAccount());
                }
              });
            },
          ).show();
        }
      }
    }, builder: (context, state) {
      var cubit = BankAccountCubit.get(context);

      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('بيانات حسابك البنكي'),
            leading:IconButton(onPressed:(){
              Navigator.pop(context);
            }, icon:Icon(Icons.arrow_back_ios_sharp,color: MyColors.white,),),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    controller: fNameControler,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'أدخل أسمك الرباعي',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    controller: emailControler,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'أدخل الأيميل الخاص بك',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    controller: userAccountControler,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'أدخل رقم الفيزا كارد الخاص بك',
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    controller: passControler,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: ' أدخل كلمة السر للفيزا كارد',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 370,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      cubit.Bank_data(
                          full_name: fNameControler.text,
                          email: emailControler.text,
                          user_account: userAccountControler.text,
                          userid: tokens,
                          password: passControler.text);
                    },
                    child: Text("تسجيل للتبرع"),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('هل لديك حساب لدينا ؟ '),
                    TextButton(
                        onPressed: () {
                          CacheHelper.SaveData(key: 'bank_data', value:true).then((value) {
                            if (value) {
                              navigateTo(context,LoginBankAccount());
                            }
                          });
                        },
                        child: Text(
                          ' تسجيل دخول لحسابك البنكي',
                          style: TextStyle(color:MyColors.green,fontWeight: FontWeight.w100),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
