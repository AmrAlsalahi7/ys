part of 'project_cubit.dart';

@immutable
abstract class ProjectState {}

class ProjectInitial extends ProjectState {}

class LoadingPostProjectState extends ProjectState {}


class SuccessPostProjectState extends ProjectState {}


class ErorrPostProjectState extends ProjectState {}

class SuccessPerson extends ProjectState {}

class PaymentProLoadingState extends ProjectState {}

class PaymentProSuccessState extends ProjectState {
  final PaymentModel paymentModel;

  PaymentProSuccessState(this.paymentModel);

}

class PaymentProErorrState extends ProjectState {}

class AppChangedBottomSheet extends ProjectState {}

class SuccessDeposit extends ProjectState {}

class SuccessMoney extends ProjectState {}
