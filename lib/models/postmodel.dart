class PostModel {
  bool? status;
   String? message;
  List<DataPost>? data;


  PostModel.fromJson(Map< String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataPost>[];
      json['data'].forEach((v) {
        data!.add(DataPost.fromJson(v));
      });
    }
  }

}

class DataPost {
   int? postId;
   String? imagePost;
   String? amount;
   String? title_post;
   int? statusId;
   int? personNum;
   int? donationId;
   int? oppId;
   int? instId;
   String? city;
   String? street;
   int? status;
   int? empId;
   String? dateTime;
   String? note;
   String? type;
   String? instName;
   String? empName;
   String? oppTyoe;



  DataPost.fromJson(Map< String, dynamic> json) {
    postId = json['post_id'];
    imagePost = json['image_post'];
    title_post=json['title_post'];
    amount=json['amount'];
    statusId = json['status_id'];
    personNum = json['person_num'];
    donationId = json['donation_id'];
    oppId = json['opp_id'];
    instId = json['inst_id'];
    city = json['city'];
    street = json['street'];
    status = json['status'];
    empId = json['emp_id'];
    dateTime = json['date_time'];
    note = json['note'];
    type = json['type'];
    instName = json['inst_name'];
    empName = json['emp_name'];
    oppTyoe = json['opp_tyoe'];
  }


}