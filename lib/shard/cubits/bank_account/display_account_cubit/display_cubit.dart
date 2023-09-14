import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ys/Network/endpoint.dart';
import 'package:ys/Network/remot/dio_helper.dart';
import 'package:ys/models/bankAccount.dart';

part 'display_state.dart';

class DisplayCubit extends Cubit<DisplayState> {
  DisplayCubit() : super(DisplayInitial());

  static DisplayCubit get(context) => BlocProvider.of(context);


  late BankAccountModel bankAccountModel;
  void displayAccount({int? userid}) {
    emit(AccountLoadingState());
    DioHelper.postData(url: BankAccountDisplay, data: {'user_id': userid})
        .then((value) {
      bankAccountModel = BankAccountModel.fromJson(value.data);
      print(value.data);

      emit(SearchMedSuccessState(bankAccountModel));
    }).catchError((erorr) {
      emit(SearchMedErorrState());
    });
  }
}
