import 'package:flutter/material.dart';
import 'package:ys/models/registerUser.dart';
abstract class RegisterDataAuthStates{}
class DataAuthInitialState extends RegisterDataAuthStates{}
class Registerloading extends RegisterDataAuthStates
{

}
class RegisterUserStatesSuccess extends RegisterDataAuthStates
{
   Register register;

  RegisterUserStatesSuccess(this.register);

}
class RegisterErrorOccurred extends RegisterDataAuthStates
{
  final String errorMsg;

  RegisterErrorOccurred({required this.errorMsg});
}
class authStateChanges extends RegisterDataAuthStates{}
class authStateNotChanges extends RegisterDataAuthStates{}
