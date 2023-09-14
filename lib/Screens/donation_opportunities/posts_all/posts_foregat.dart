import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ys/Network/endpoint.dart';
import 'package:ys/Network/local/cache_helper.dart';
import 'package:ys/Screens/Bank_account/login_bank_account/login_bank.dart';
import 'package:ys/Screens/Bank_account/register_bank/Bank_data.dart';
import 'package:ys/Screens/details_post/details_posts.dart';
import 'package:ys/models/postmodel.dart';
import 'package:ys/shard/common/myColors.dart';
import 'package:ys/shard/common/widgets.dart';
import 'package:ys/shard/cubits/postscubit/posts_foregat/foregat_cubit.dart';

class ForegatPosts extends StatelessWidget {
  //Key of Scaffold Controll The Screen as you Like
  var ScafoldKey = GlobalKey<ScaffoldState>();
  //Key of Form Controll The Form as you Like
  var FormKey = GlobalKey<FormState>();

  var paycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          key: ScafoldKey,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        ButtonYOSR(
                            function: () {},
                            text: 'المشاريع العامة ',
                            width: 120),
                        SizedBox(
                          width: 3,
                        ),
                        ButtonYOSR(
                            function: () {},
                            text: 'مشاريع الأسكان ',
                            width: 120),
                        SizedBox(
                          width: 3,
                        ),
                        ButtonYOSR(
                            function: () {},
                            text: 'كفالة الأيتام ',
                            width: 120),
                        SizedBox(
                          width: 3,
                        ),
                        ButtonYOSR(
                            function: () {},
                            text: 'العناية بالمساجد ',
                            width: 120),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<ForegatCubit, ForegatState>(
                  builder: (context, state) {
                    return ConditionalBuilder(
                      condition:  ForegatCubit.get(context).postModel != null &&
                          ForegatCubit.get(context).postModel!.data != null,
                      builder: (context) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: ForegatCubit.get(context)
                                .postModel!
                                .data!
                                .length,
                            itemBuilder: (BuildContext context, index) {
                              return buildForegatPost(
                                  ForegatCubit.get(context)
                                      .postModel!
                                      .data![index],
                                  context);
                            },
                          ),
                        );
                      },
                      fallback: (context) => Center(
                        child: Text('لا يوجد بيانات'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );

  }

  Widget buildForegatPost(DataPost dataPost, BuildContext context) {
    var cubit = ForegatCubit.get(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              navigateTo(
                  context,
                  DetailsPost(
                    dataPost: dataPost,
                  ));
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    width: 2, style: BorderStyle.solid, color: Colors.green),
                borderRadius: BorderRadius.all(Radius.circular(13.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                      child: dataPost.imagePost!.isEmpty
                          ? Image.asset('assets/images/yosrlogo.jpg')
                          : FadeInImage.assetNetwork(
                              placeholder: "assets/images/yosrlogo.jpg",
                              image: '${ImageLocal}' + dataPost.imagePost!,
                            ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Container(
                        height: 120.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${dataPost.title_post}',
                              style: Theme.of(context).textTheme.bodyText1,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'المبلغ المطلوب',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '${dataPost.amount} ريال يمني ',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              child: ButtonYOSR(
                                text: 'تبرع الان',
                                function: () {
                                  int bk_token =
                                      CacheHelper.GetData(key: 'bk_id');
                                  bool bank_data =
                                      CacheHelper.GetData(key: 'bank_data');
                                  int user_id =
                                      CacheHelper.GetData(key: 'id');
                                  if (bank_data != null) {
                                    if (bk_token != null) {
                                      if (cubit.isShowSheetShown) {
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
                                                                  cubit
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
                                  } else {
                                    navigateTo(context, BankData());
                                  }
                                },
                                radius: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
