import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ys/Network/local/cache_helper.dart';
import 'package:ys/Screens/auth/loginScreen/sign_in_screen.dart';
import 'package:ys/constants.dart';
import 'package:ys/shard/common/widgets.dart';
import 'package:ys/shard/cubits/RegisterData/Register_Cubit.dart';
import 'package:ys/shard/cubits/auth-phone/PhoneAuthcubit.dart';
import 'package:ys/shard/cubits/login/login_auth_cubit.dart';
class Profile extends StatelessWidget {
  final phoneNumber;
  AuthCubit authCubit = AuthCubit();
  RegisterDataAuthCubit RegisterCubit = RegisterDataAuthCubit();

  Profile({Key? key, this.phoneNumber}) : super(key: key);
 late var user = CacheHelper.GetData(key: 'username');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginAuthCubit, LoginAuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 115,
                  width: 115,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black54,
                        width: 2.5,
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          backgroundColor: kPrimaryColor,
                          child: Icon(
                            Icons.person, color: Colors.black, size: 90,),
                        ),
                        Positioned(
                          right: -16,
                          bottom: 0,
                          child: SizedBox(
                            height: 46,
                            width: 46,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(color: Colors.black),
                                ),
                                primary: Colors.white,
                                backgroundColor: Color(0xFFF5F6F9),
                              ),
                              onPressed: () {},
                              child: Icon(
                                Icons.camera_enhance, color: Colors.green,),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ConditionalBuilder(
                  condition:LoginAuthCubit.get(context).userModle != null
                  && LoginAuthCubit.get(context).userModle!.data != null,
                  builder: (context) => Text(LoginAuthCubit.get(context).userModle!.data!.username!),
                  fallback: (context)=>Text('لا يوجد بيانات'),
                ),
                SizedBox(height: 10),
                ProfileMenu(
                  text: "عـن يـســر",
                  // text: "Help Center",
                  icon: Icons.document_scanner_sharp,
                  press: () {

                  },
                ),
                ProfileMenu(
                  text: "مراكز التواصل",
                  // text: "Help Center",
                  icon: Icons.phone,
                  press: () {},
                ),
                ProfileMenu(
                  text: "الأسئلة الشائعة",
                  // text: "Help Center",
                  icon: Icons.question_answer_outlined,
                  press: () {},
                ),
                ProfileMenu(
                  text: "سياسة الخصوصية",
                  // text: "Help Center",
                  icon: Icons.lock_open_outlined,
                  press: () {},
                ),
                ProfileMenu(
                  text: "تسجيل الخروج",
                  // text: "Help Center",
                  icon: Icons.exit_to_app,
                  press: () {
                    // signOut(context);
                    CacheHelper.removeData(key: 'id');
                    CacheHelper.removeData(key: 'bk_id');
                    CacheHelper.removeData(key: 'username');
                    navigateAndFinish(context, SignInScreen());
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget ProfileMenu({
    required text,
    required IconData icon,
    press,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: kPrimaryColor,
          padding: EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            // SvgPicture.asset(
            //   icon,
            //   color: kPrimaryColor,
            //   width: 22,
            // ),
            Icon(icon),
            SizedBox(width: 20),
            Expanded(child: Text(text)),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
