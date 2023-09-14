import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ys/Network/endpoint.dart';
import 'package:ys/Network/remot/dio_helper.dart';
import 'package:ys/models/count_person_model.dart';
import 'package:ys/models/countdeposit_model.dart';
import 'package:ys/models/countmoney_model.dart';
import 'package:ys/models/payment_model.dart';
import 'package:ys/models/postmodel.dart';

part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit() : super(ProjectInitial());

  static ProjectCubit get(context) => BlocProvider.of(context);
  PostModel? postModel;

  void showPostsProject(){
    emit(LoadingPostProjectState());
    DioHelper.postData(url: PostShowProject,).then((value){
      postModel =PostModel.fromJson(value.data);
      print("============================================");
      print(value.data);
      emit(SuccessPostProjectState());
    }).catchError((erorr){
      emit(ErorrPostProjectState());
    });
  }
  //Counts The Person's Help
  CountPersonModel? countPersonModel;
  void countPerson(){
    // emit(LoadingPostProjectState());
    DioHelper.postData(url: CountPersons).then((value){
      countPersonModel = CountPersonModel.fromJson(value.data);

      print(value.data);
      emit(SuccessPerson());
    }).catchError((erorr){
      print(erorr);
    });
  }

  //Counts All Money
  CountMoneyModel? countMoneyModel;
  void countMoney(){
    // emit(LoadingPostProjectState());
    DioHelper.postData(url: CountMoney).then((value){
      countMoneyModel = CountMoneyModel.fromJson(value.data);
      print("++++++++++++++++++++++++++++++++++++");
      print(value.data);
      emit(SuccessMoney());
    }).catchError((erorr){

    });
  }
  //Counts All deposit
   CountDepositModel? countDepositModel;
  void countDeposit(){
    // emit(LoadingPostProjectState());
    DioHelper.postData(url: CountDeposit,).then((value){
      countDepositModel = CountDepositModel.fromJson(value.data);
      print(value.data);
      emit(SuccessDeposit());
    }).catchError((erorr){

    });
  }


  //for sheetbottom hide or show
  bool isShowSheetShown = false;
  //for change icon
  IconData fIcon = Icons.edit;

  void changebottomsheet({
    required bool isShow,
    required IconData icon,
  }) {
    isShowSheetShown = isShow;
    fIcon = icon;
    emit(AppChangedBottomSheet());
  }
//PayMent Function
  PaymentModel? paymentModel;
  void paymentFun(
      {required int bk_id,
        required int user_id,
        required String amount,
        required int post_id}) {
    emit(PaymentProLoadingState());
    DioHelper.postData(url: PaymentEnd, data: {
      'bk_id': bk_id,
      'user_id':user_id,
      'amount': amount,
      'post_id': post_id,
    }).then((value) {
      paymentModel = PaymentModel.fromJson(value.data);
      print(value.data);
      emit(PaymentProSuccessState(paymentModel!));
    }).catchError((erorr) {
      emit(PaymentProErorrState());
      print(erorr.toString());
      print("data not send");
    });
  }

}
