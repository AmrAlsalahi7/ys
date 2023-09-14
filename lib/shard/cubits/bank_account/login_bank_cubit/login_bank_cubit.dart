import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ys/Network/endpoint.dart';
import 'package:ys/Network/remot/dio_helper.dart';
import 'package:ys/models/login_bank_model.dart';

part 'login_bank_state.dart';

class LoginBankCubit extends Cubit<LoginBankState> {
  LoginBankCubit() : super(LoginBankInitial());

  static LoginBankCubit get(context) => BlocProvider.of(context);

 late LoginBankModel loginBankModel;
  void loginBank({required int user_id,required String account, required String passwords}) {
    emit(LoginBankLoading());
    DioHelper.postData(url: LoginAccountBank, data:
    {
      'user_id':user_id,
      'account': account,
      'password': passwords
    })
        .then((value) {
      loginBankModel = LoginBankModel.fromJson(value.data);
       print(value.data);
      emit(LoginBankSuccess(loginBankModel));
    }).catchError((erorr) {
      print(erorr.toString());
      emit(LoginBankAuthError());
      print("not validat");

    });
  }
}
