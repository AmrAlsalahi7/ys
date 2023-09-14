class PaymentModel {
  late bool status;
  late  String message;


  PaymentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }


}