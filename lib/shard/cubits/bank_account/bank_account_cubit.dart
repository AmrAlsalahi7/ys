import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ys/Network/endpoint.dart';
import 'package:ys/Network/remot/dio_helper.dart';

import '../../../models/bk_account_model.dart';

part 'bank_account_state.dart';

class BankAccountCubit extends Cubit<BankAccountState> {
  DioHelper dio = DioHelper();
  // String token = CacheHelper.GetData(key: "id"); // Still empty
  BankAccountCubit() : super(BankAccountInitial());

  static BankAccountCubit get(context) => BlocProvider.of(context);

  BankAccountModel? bankAccountModel;

  void Bank_data(
      {required String full_name,
      required String email,
      required String user_account,
        required int userid,
      required String password}) {
    emit(BankAccountLoading());
    DioHelper.postData(url: bank_accountUrl, data: {
      'full_name': full_name,
      'email': email,
      "user_account": user_account,
      'password': password,
      "user_id": userid,
    }).then((value) {
      bankAccountModel = BankAccountModel.fromJson(value.data);
      print(value.data);
      emit(BankAccountSuccess(bankAccountModel!)); // i have to pass model
    });
// if(state is UserStatesSuccess)
//   {
//     navigateTo(context, widget)
//   }
  }
}
