class LoginBankModel {
  late bool status;
  late String message;
  late DataBankLogin data;


  LoginBankModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null  ? DataBankLogin.fromJson(json['data']) : null!;
  }

}

class DataBankLogin {
 late String bkId;
 late String fullName;
 late String email;
 late String userAccount;
 late String password;
 late String userId;
 late String amount;
 late String dateReg;


  DataBankLogin.fromJson(Map<String, dynamic> json) {
    bkId = json['bk_id'];
    fullName = json['full_name'];
    email = json['email'];
    userAccount = json['user_account'];
    password = json['password'];
    userId = json['user_id'];
    amount = json['amount'];
    dateReg = json['date_reg'];
  }
}