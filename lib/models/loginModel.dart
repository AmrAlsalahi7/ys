class UserModel {
   bool? status;
  String? message;
   Data? data;


   UserModel.fromJson(Map<String, dynamic> json) {
     status = json['status']??"";
     message = json['message']??"";
     data = json['data'] != null ?  Data.fromJson(json['data']) : null;
   }
}

class Data {
   int? userId;
   String? username;
   String? phone;
   String? password;
   int? status;


  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id']??"";
    username = json['username'];
    phone = json['phone'];
    password = json['password'];
    status = json['status'];
  }

}
