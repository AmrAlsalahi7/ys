part of 'display_cubit.dart';

@immutable
abstract class DisplayState {}

class DisplayInitial extends DisplayState {}

class AccountLoadingState extends DisplayState {}

class SearchMedSuccessState extends DisplayState {
 final BankAccountModel bankmodel;
  SearchMedSuccessState(this.bankmodel);
}

class SearchMedErorrState extends DisplayState {}
