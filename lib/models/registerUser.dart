class Register {
  late bool status;
  late  String message;


  Register.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}