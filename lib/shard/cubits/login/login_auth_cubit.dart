import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ys/Network/endpoint.dart';
import 'package:ys/Network/remot/dio_helper.dart';
import 'package:ys/models/loginModel.dart';

part 'login_auth_state.dart';

class LoginAuthCubit extends Cubit<LoginAuthState> {


  LoginAuthCubit() : super(LoginAuthInitial());
  static LoginAuthCubit get(context) => BlocProvider.of(context);

   final List<String> errors = [];

  void addErorr({String? error}) {
    if (!errors.contains(error)) errors.add(error!);
    emit(LoginErorrForm());
  }

  void removeError({String? error}) {
    if (errors.contains(error)) errors.remove(error);
    emit(LoginErorrForm());
  }
  UserModel? userModle;

  void loginIn({required String? phone, required String? passwords}) {
    emit(LoginAuthLoading());
    DioHelper.postData(url: sign_in, data:
    {
      'phone': phone, 'password': passwords})
        .then((value) {
      userModle = UserModel.fromJson(value.data);
      print(value.data);
      emit(LoginAuthSuccess(userModel: userModle!));
    });
  }


}
