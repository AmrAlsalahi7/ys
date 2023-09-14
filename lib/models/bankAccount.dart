class BankAccountModel {
   bool? status;
   String? message;
  Data? data;


  BankAccountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null  ? Data.fromJson(json['data']) : null);
  }


}

class Data {
  int? bkId;
  String? fullName;
  String? email;
  String? userAccount;
  String? password;
  int? userId;
  String? amount;
  String? dateReg;
  String? username;


  Data.fromJson(Map< String, dynamic> json) {
    bkId = json['bk_id'];
    fullName = json['full_name'];
    email = json['email'];
    userAccount = json['user_account'];
    password = json['password'];
    userId = json['user_id'];
    amount = json['amount'];
    dateReg = json['date_reg'];
    username = json['username'];
  }

}