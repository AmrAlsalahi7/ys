import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ys/Network/endpoint.dart';
import 'package:ys/Network/remot/dio_helper.dart';
import 'package:ys/models/payment_model.dart';
import 'package:ys/models/postmodel.dart';

part 'foregat_state.dart';

class ForegatCubit extends Cubit<ForegatState> {
  ForegatCubit() : super(ForegatInitial());

  static ForegatCubit get(context) => BlocProvider.of(context);
  PostModel? postModel;

  void showPostsForegat() {
    emit(LoadingPostForegatState());
    DioHelper.postData(
      url: PostShowForegat,
    ).then((value) {
      postModel = PostModel.fromJson(value.data);
      print(value.data);
      emit(SuccessPostForegatState());
    }).catchError((erorr) {
      emit(ErorrPostForegatState());
    });
  }

  PaymentModel? paymentModel;
  void paymentFun(
      {required int bk_id,
      required int user_id,
      required String amount,
      required int post_id}) {
    emit(PaymentForLoadingState());
    DioHelper.postData(url: PaymentEnd, data: {
      'bk_id': bk_id,
      'user_id':user_id,
      'amount': amount,
      'post_id': post_id,
    }).then((value) {
      paymentModel = PaymentModel.fromJson(value.data);
      print(value.data);
      emit(PaymentForSuccessState(paymentModel!));
    }).catchError((erorr) {
      emit(PaymentForErorrState());
      print(erorr.toString());
      print("data not send");
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
}
