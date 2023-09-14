import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ys/Network/local/cache_helper.dart';
import 'package:ys/Screens/auth/loginScreen/sign_in_screen.dart';
import 'package:ys/shard/common/myColors.dart';
import 'package:ys/shard/common/widgets.dart';
import 'package:ys/shard/cubits/auth-phone/PhoneAuthcubit.dart';
import 'package:ys/shard/cubits/auth-phone/PhoneAuthstate.dart';
class OtpScreen extends StatelessWidget {
  final phoneNumber;

   OtpScreen({required this.phoneNumber});

 late String otpCode;

  Widget _buildIntoScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "تأكيد رقم الهاتف ",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2.0),
          child: RichText(
            text: TextSpan(
              text: "ادخل 6 ارقام المرسله الى ",
              style: TextStyle(color: Colors.black, fontSize: 18, height: 1.4),
              children: <TextSpan>
              [
                TextSpan
                  (
                  text: '$phoneNumber',style: TextStyle(color: MyColors.green)
                ),

              ]
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildPinCodeFields(BuildContext context) {
    return Container(
      child:PinCodeTextField(
        autoFocus: true,
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        appContext: context,
      length: 6,
      obscureText: false,
      animationType: AnimationType.scale,

      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        borderWidth: 1,
        activeColor: Colors.green,
        inactiveColor: MyColors.green,
        inactiveFillColor: MyColors.white,
        activeFillColor: Colors.lightGreen,
        selectedColor: MyColors.green,
        selectedFillColor: Colors.white,

      ),
      animationDuration: Duration(milliseconds: 300),
      backgroundColor: Colors.white,
      enableActiveFill: true,
      onCompleted: (subMitedCode) {
          otpCode=subMitedCode;
        print("Completed");
      },
      onChanged: (value) {
        print(value);
      },

    ) ,);
  }
  void _login(BuildContext context) {
    BlocProvider.of<AuthCubit>(context).submitOtp(otpCode);
    print("PhonenUMBER IS : "+phoneNumber);
  }
  Widget _buildVrifyButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ElevatedButton(
        onPressed: ()
        {
          showProgressIndicator(context);
          _login(context);
        },
        child: Text(
          "تحقق",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          maximumSize: Size(110, 50),
          primary: Colors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );

  }
  Widget _buildPhoneVerficationBloc() {
  return BlocListener<AuthCubit, AuthStates>(
    // listining when state change
    listenWhen: (previous, current)  {
      return previous != current;
    },
    listener: (context, state) {
      if (state is loading) {
        showProgressIndicator(context);
      }
      if(state is PhoneOtpVerify)
      {
        Navigator.pop(context);
        CacheHelper.sharedpref.setString("phone", phoneNumber);//.....................................test
       var phone= CacheHelper.sharedpref.getString("phone");//.....................................test
        // Navigator.of(context).pushReplacementNamed(registerScreen,arguments: phone);
// navigateTo(context, LoginDataScreens
        navigateTo(context, SignInScreen());


      }
      if ( state is ErrorOccurred)
      {
        // Navigator.pop(context);
        String errorMsg=(state).errorMsg;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
            errorMsg),
          backgroundColor: Colors.black,
          duration: Duration(seconds: 3),));
      }
    },
    child: Container(),
  );
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        backgroundColor: Colors.white,
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 88),
          child: Column(
            children: [
              _buildIntoScreen(),
              SizedBox(
                height: 88,
              ),
              _buildPinCodeFields(context),
              SizedBox(
                height: 60,
              ),
              _buildVrifyButton(context),
              _buildPhoneVerficationBloc()
            ],
          ),
        ),
      ),
    );
  }
}
