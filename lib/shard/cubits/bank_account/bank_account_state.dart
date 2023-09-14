part of 'bank_account_cubit.dart';

@immutable
abstract class BankAccountState {}

class BankAccountInitial extends BankAccountState {}
class BankAccountLoading extends BankAccountState {}
class BankAccountSuccess extends BankAccountState {
   BankAccountModel bankAccountModel;

  BankAccountSuccess(this.bankAccountModel);

}
class BankAccountError extends BankAccountState
{
  final String errorMsg;

  BankAccountError({required this.errorMsg});


}
