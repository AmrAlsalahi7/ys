

import 'package:ys/models/payment_model.dart';
import 'package:ys/models/postmodel.dart';

class PostState {}

class initialPostState extends PostState{}

class SuccessPostState extends PostState{


  SuccessPostState();
}

class ErorrPostState extends PostState{
 final PostModel postModel;

 ErorrPostState(this.postModel);
}

class LoadingPostState extends PostState{


 LoadingPostState();
}


class PaymentTeasrtLoadingState extends PostState{}

class PaymentTeasrtSuccessState extends PostState{
 final PaymentModel paymentModel;

  PaymentTeasrtSuccessState(this.paymentModel);

}

class PaymentTeasrtErorrState extends PostState{}

class AppChangedBottomSheet extends PostState{}