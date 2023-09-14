import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:ys/Network/endpoint.dart';
import 'package:ys/Network/local/cache_helper.dart';
import 'package:ys/Screens/Bank_account/login_bank_account/login_bank.dart';
import 'package:ys/Screens/Bank_account/register_bank/Bank_data.dart';
import 'package:ys/models/postmodel.dart';
import 'package:ys/shard/common/myColors.dart';
import 'package:ys/shard/common/widgets.dart';
import 'package:ys/shard/cubits/postscubit/posts_projects/project_cubit.dart';

class DetailsPost extends StatelessWidget {
  DetailsPost({Key? key,required this.dataPost}) : super(key: key);
  DataPost dataPost;

  //Key of Scaffold Controll The Screen as you Like
  var ScafoldKey = GlobalKey<ScaffoldState>();
  //Key of Form Controll The Form as you Like
  var FormKey = GlobalKey<FormState>();

  var paycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: ScafoldKey,
        appBar: AppBar(

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 420,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: MyColors.green),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dataPost.imagePost!.isEmpty ? Image.asset('assets/images/yosrlogo.jpg'):
                      FadeInImage.assetNetwork(
                        placeholder:"assets/images/yosrlogo.jpg",
                        image:  '${ImageLocal}'+dataPost.imagePost!,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        dataPost.title_post!,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        dataPost.note!,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding:
                              const EdgeInsets.symmetric(vertical: 8, horizontal: 9),
                          width: 400,
                          color: Colors.green[700],
                          child: Row(
                            children: [
                              Text('رقم الحالة :\t ${dataPost.postId}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Spacer(),
                              Icon(Icons.share,color: Colors.white,),

                            ],
                          ),
                      ),
                      SizedBox(height: 9,),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 9),
                        width: 400,
                        color: Colors.green[700],
                        child: Row(
                          children: [
                            Text('المدينة :\t ${dataPost.city}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Spacer(),
                            Icon(Icons.location_city,color: Colors.white,),

                          ],
                        ),
                      ),
                      SizedBox(height: 9,),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 9),
                        width: 400,
                        color: Colors.green[700],
                        child: Row(
                          children: [
                            Text('عدد المستفيدين  :\t ${dataPost.personNum}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                            ),
                            Spacer(),
                            Icon(Icons.person_pin_sharp,color: Colors.white,),

                          ],
                        ),
                      ),
                      SizedBox(height: 9,),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 9),
                        width: 400,
                        color: Colors.green[700],
                        child: Row(
                          children: [
                            Text('الشريك المنفذ :\t ${dataPost.instName}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Spacer(),
                            Icon(Icons.home_work_outlined,color: Colors.white,),

                          ],
                        ),
                      ),
                      SizedBox(height: 9,),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 9),
                        width: 400,
                        color: Colors.green[700],
                        child: Row(
                          children: [
                            Text('نوع المستفيد :\t ${dataPost.type}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Spacer(),
                            Icon(Icons.clean_hands_outlined,color: Colors.white,),

                          ],
                        ),
                      ),
                      SizedBox(height: 9,),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 9),
                        width: 400,
                        color: Colors.green[700],
                        child: Row(
                          children: [
                            Text('نوع الفرصة :\t ${dataPost.oppTyoe}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Spacer(),
                            Icon(Icons.clean_hands_sharp,color: Colors.white,),

                          ],
                        ),
                      ),
                      SizedBox(height: 9,),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 9),
                        width: 400,
                        color: Colors.green[700],
                        child: Row(
                          children: [
                            Text('تاريخ الفرصة :\t ${dataPost.dateTime}',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Spacer(),
                            Icon(Icons.date_range_outlined,color: Colors.white,),

                          ],
                        ),
                      ),
                      SizedBox(height: 15,),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text('تم جمع',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              Spacer(),
                              Text('المبلغ المتبقي',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),

                            ],
                          ),
                          Row(
                            children: [
                              Text('20000 R.Y',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              Spacer(),
                              Text('40000 R.Y',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),

                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 55,),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
           late var bk_token =CacheHelper.GetData(key: 'bk_id')??'';
           late bool bank_dat =CacheHelper.GetData(key: 'bank_data') ?? false;
           late var user_id =
            CacheHelper.GetData(key: 'id');
            if(bank_dat) {
              if (bk_token != '') {
                if (ProjectCubit.get(context)
                    .isShowSheetShown) {
                  if (FormKey.currentState!.validate()) {
                    // cubit.InsertToDatabase(
                    //   title: titlecontroller.text,
                    //   date: datecontroller.text,
                    //   time: timecontroller.text,);
                  }
                } else {
                  ScafoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                      padding: EdgeInsets.all(20.0),
                      color: Colors.grey[200],
                      child: Form(
                        key: FormKey,
                        child: Column(
                          mainAxisSize:
                          MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller:
                              paycontroller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'الرجاءأدخل المبلغ الذي تريد التبرع به';
                                }
                                return null;
                              },
                              decoration:
                              const InputDecoration(
                                border:
                                OutlineInputBorder(),
                                labelText:
                                'أدخل المبلغ الذي تريد التبرع به',
                                prefixIcon:
                                Icon(Icons.money),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            ButtonYOSR(
                                function: () {
                                  if (FormKey
                                      .currentState!
                                      .validate()) {
                                    AwesomeDialog(
                                      context:
                                      context,
                                      dialogType:
                                      DialogType
                                          .success,
                                      headerAnimationLoop:
                                      false,
                                      animType: AnimType
                                          .rightSlide,
                                      title:
                                      'هل أنت متأكد من أجرى العملية ؟',
                                      desc: '',
                                      btnOkOnPress:
                                          () {
                                        ProjectCubit.get(
                                            context)
                                            .paymentFun(
                                          bk_id:
                                          bk_token,
                                          user_id:
                                          user_id,
                                          amount:
                                          paycontroller
                                              .text,
                                          post_id:
                                          dataPost
                                              .postId!,
                                        );
                                        Navigator.pop(
                                            context);
                                        final snackBar =
                                        SnackBar(
                                          backgroundColor:
                                          MyColors
                                              .green,
                                          content: Text(
                                              'العملية تمت بنجاح'),
                                        );
                                        ScaffoldMessenger.of(
                                            context)
                                            .showSnackBar(
                                            snackBar);
                                      },
                                      btnCancelOnPress:
                                          () {},
                                    ).show();
                                  }
                                },
                                text: 'تبرع'),
                          ],
                        ),
                      ),
                    ),
                  )
                      .closed
                      .then((value) {
                    Navigator.canPop(context);
                  });
                  paycontroller.clear();
                }
              } else {
                navigateTo(context, LoginBankAccount());
              }
            }else{
              navigateTo(context, BankData());
            }
          },
          isExtended: true,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          icon: Icon(Icons.add_box_outlined),
          label: Text('تبرع الان'),
        ),
      ),
    );
  }
}
