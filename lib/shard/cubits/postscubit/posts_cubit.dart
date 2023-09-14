import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ys/Network/endpoint.dart';
import 'package:ys/Network/remot/dio_helper.dart';
import 'package:ys/models/payment_model.dart';
import 'package:ys/models/postmodel.dart';
import 'package:ys/shard/cubits/postscubit/posts_state.dart';

class PostCubit extends Cubit<PostState>{

  PostCubit() : super(initialPostState());

  static PostCubit get(context) => BlocProvider.of(context);
  PostModel? postModel;

  void showPostsTeasrt(){
    emit(LoadingPostState());
    DioHelper.postData(url: PostShowTeasrt,).then((value){
      postModel =PostModel.fromJson(value.data);
      print(value.data);
      emit(SuccessPostState());
    }).catchError((erorr){
      print(erorr);
    });

  }

  //for sheetbottom hide or show
  bool isShowSheetShown = false;
  //for change icon
  IconData fIcon = Icons.edit;

  void changebottomsheet({
    required bool isShow ,
    required IconData icon,
  }) {
    isShowSheetShown = isShow;
    fIcon = icon;
    emit(AppChangedBottomSheet());
  }

  PaymentModel? paymentModel;
  void paymentFun(
      {
        required int bk_id,
        required int user_id,
        required String amount,
        required int post_id}) {
    emit(PaymentTeasrtLoadingState());
    DioHelper.postData(url: PaymentEnd, data: {
      'bk_id': bk_id,
      'user_id':user_id,
      'amount': amount,
      'post_id': post_id,
    }).then((value) {
      paymentModel = PaymentModel.fromJson(value.data);
      print(value.data);
      emit(PaymentTeasrtSuccessState(paymentModel!));
    }).catchError((erorr) {
      emit(PaymentTeasrtErorrState());
      print(erorr.toString());
      print("data not send");
    });
  }


}