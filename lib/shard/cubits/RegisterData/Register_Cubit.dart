
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ys/Network/endpoint.dart';
import 'package:ys/Network/remot/dio_helper.dart';
import 'package:ys/models/registerUser.dart';
import 'package:ys/shard/cubits/RegisterData/RegisterState.dart';

class RegisterDataAuthCubit extends Cubit<RegisterDataAuthStates> {
  // EmployeeModel userModle;
DioHelper dio=DioHelper();


  RegisterDataAuthCubit() : super(DataAuthInitialState());

  static RegisterDataAuthCubit get(context) => BlocProvider.of(context);

late Register register;

  void signUp(
      {required String username,required String phone, required String password}) {
    emit(Registerloading());
    DioHelper.postData(url: sign_up, data: {
      'username': username,
      'phone': phone,
      'password': password,
    }).then((value) {
      register = Register.fromJson(value.data);
      //print(value.data);
      emit(RegisterUserStatesSuccess(register)); // i have to pass model
    }).catchError((erorr) {
      emit(RegisterErrorOccurred(errorMsg: erorr)); // i have to pass model
      print(erorr.toString());
      print("data not send");
    });
  }
void authStateChange()
async{
  // await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((user)
  {
    if(user==null)
    {
      emit(authStateNotChanges());
    }
    else
    {
      emit(authStateChanges());    }
  });
}


}
