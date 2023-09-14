part of 'login_auth_cubit.dart';

@immutable
abstract class LoginAuthState {}

class LoginAuthInitial extends LoginAuthState {}
class LoginAuthLoading extends LoginAuthState
{

}
class LoginAuthSuccess extends LoginAuthState
{
  final UserModel userModel;

  LoginAuthSuccess({required this.userModel});
}


class LoginAuthError extends LoginAuthState
{
  final String errorMsg;

  LoginAuthError({required this.errorMsg});
}

class LoginErorrForm  extends LoginAuthState{}