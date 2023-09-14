part of 'foregat_cubit.dart';

@immutable
abstract class ForegatState {}

class ForegatInitial extends ForegatState {}

class LoadingPostForegatState extends ForegatState {}


class SuccessPostForegatState extends ForegatState {}


class ErorrPostForegatState extends ForegatState {}

class AppChangedBottomSheet extends ForegatState {}


//PaymentForState

class PaymentForLoadingState extends ForegatState {}

class PaymentForSuccessState extends ForegatState {
 final PaymentModel paymentModel;

  PaymentForSuccessState(this.paymentModel);

}

class PaymentForErorrState extends ForegatState {}

