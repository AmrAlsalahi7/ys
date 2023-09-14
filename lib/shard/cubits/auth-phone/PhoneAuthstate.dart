import 'package:flutter/cupertino.dart';

abstract class AuthStates{}

class AuthInitialState extends AuthStates {}

class loading extends AuthStates {}
class ErrorOccurred extends AuthStates
{
  final String errorMsg;

  ErrorOccurred({required this.errorMsg});
}
class PhoneNumSub extends AuthStates{}
class PhoneOtpVerify extends AuthStates{}

// class ChangeBottomNavIndexState extends AuthStates{}