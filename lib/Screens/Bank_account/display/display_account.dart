import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ys/Network/local/cache_helper.dart';
import 'package:ys/layout/homeScreen.dart';
import 'package:ys/models/bankAccount.dart';
import 'package:ys/shard/common/widgets.dart';
import 'package:ys/shard/cubits/bank_account/display_account_cubit/display_cubit.dart';

class DisplayAccount extends StatelessWidget {
  DisplayAccount({Key? key, required this.token}) : super(key: key);
  int token;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DisplayCubit()..displayAccount(userid: token),
      child: BlocConsumer<DisplayCubit, DisplayState>(
        listener: (context, state) {},
        builder: (context, state) {
          print(token);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConditionalBuilder(
                    condition: DisplayCubit.get(context).bankAccountModel !=
                            null &&
                        DisplayCubit.get(context).bankAccountModel.data != null,
                    builder: (context) => displayBank(
                        DisplayCubit.get(context).bankAccountModel.data!,context
                    ),
                    fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget displayBank(Data bankAccountModel, context) => Column(
        children: [
          Text('${bankAccountModel.bkId}'),
          Text('${bankAccountModel.fullName}'),
          Text('${bankAccountModel.amount}'),
          Text('${bankAccountModel.bkId}'),
          Text('${bankAccountModel.dateReg}'),
          TextButton(
              onPressed: () {
                CacheHelper.SaveData(
                  key: 'bk_id',
                  value: bankAccountModel.bkId,
                ).then((value) {
                  navigateTo(context, HomeScreen());
                });
              },
              child: Text('yes')),
        ],
      );
}
