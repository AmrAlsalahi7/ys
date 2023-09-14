class BankAccountModel {
 late bool status;
  late String message;
 late DataBank data;


  BankAccountModel.fromJson(Map< String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null  ? DataBank.fromJson(json['data']) : null)!;
  }

}

class DataBank {
  late int bkId;
  late String fullName;
  late String email;
  late String userAccount;
  late String password;
  late int userId;
  late String amount;
  late String dateReg;
  late String username;


  DataBank.fromJson(Map< String, dynamic> json) {
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

  Map< String, dynamic> toJson() {
    final Map< String, dynamic> data = new Map< String, dynamic>();
    data['bk_id'] = this.bkId;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['user_account'] = this.userAccount;
    data['password'] = this.password;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['date_reg'] = this.dateReg;
    data['username'] = this.username;
    return data;
  }
}