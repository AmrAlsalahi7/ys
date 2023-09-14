import 'package:flutter/material.dart';

const mainColor = Colors.green;
bool? tokenStatus;

// int? token = '';
const kPrimaryColor = Color(0xFF00aa55);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor =
LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);
// Form Error
final RegExp emailValidatorRegExp = RegExp(r"^[0-9.]");
//    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "فضلاً ادخل رقم جوالك";
const String kInvalidEmailError = "فضلاً ادخل رقم جوالك";
const String kPassNullError = "فضلاً ادخل كلمة السر";
const String kShortPassError = "كلمة السر قصيرة";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "ادخل اسمك";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";


final otpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: kTextColor),
  );
}
