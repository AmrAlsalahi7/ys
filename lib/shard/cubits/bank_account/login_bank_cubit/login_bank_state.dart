part of 'login_bank_cubit.dart';

@immutable
abstract class LoginBankState {}

class LoginBankInitial extends LoginBankState {}

class LoginBankLoading extends LoginBankState {}

class LoginBankSuccess extends LoginBankState {
  final LoginBankModel loginBankModel;

  LoginBankSuccess(this.loginBankModel);
}

class LoginBankAuthError extends LoginBankState {}
