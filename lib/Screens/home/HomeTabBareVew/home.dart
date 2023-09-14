import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ys/Network/endpoint.dart';
import 'package:ys/Network/local/cache_helper.dart';
import 'package:ys/Screens/Bank_account/login_bank_account/login_bank.dart';
import 'package:ys/Screens/Bank_account/register_bank/Bank_data.dart';
import 'package:ys/Screens/details_post/details_posts.dart';
import 'package:ys/models/count_person_model.dart';
import 'package:ys/models/countdeposit_model.dart';
import 'package:ys/models/countmoney_model.dart';
import 'package:ys/models/postmodel.dart';
import 'package:ys/shard/common/myColors.dart';
import 'package:ys/shard/common/widgets.dart';
import 'package:ys/shard/cubits/homeCubit/cubit.dart';
import 'package:ys/shard/cubits/postscubit/posts_projects/project_cubit.dart';

class HomeLayout extends StatelessWidget {
  @override
   // CountPersonModel? countPersonModel;

  //Key of Scaffold Controll The Screen as you Like
  var ScafoldKey = GlobalKey<ScaffoldState>();
  //Key of Form Controll The Form as you Like
  var FormKey = GlobalKey<FormState>();

  var paycontroller = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      key: ScafoldKey,
      backgroundColor: Colors.white24,
      appBar: AppBar(
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "الرئيسية",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<ProjectCubit, ProjectState>(
                builder: (context, state) {
                  return CustomSwaper(HomeCubit.get(context).sweperImage);
                },
              ),
              SizedBox(
                height: 2,
              ),
              Center(
                child: Text(
                  "_________________ من فرص التبرع ___________________",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 17,
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      '<<المزيد',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'فرص التبرع',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              BlocBuilder<ProjectCubit, ProjectState>(
                builder: (context, state) {
                  return Container(
                    height: 300.0,
                    child: ConditionalBuilder(
                      condition: ProjectCubit.get(context).postModel != null &&
                          ProjectCubit.get(context).postModel!.data != null,
                      builder: (context) => ListView.builder(
                        itemBuilder: (context, index) => _buildCarousel(
                            ProjectCubit.get(context).postModel!.data![index],
                            context, index ~/ 2),
                        itemCount:
                            ProjectCubit.get(context).postModel!.data!.length,
                      ),
                      fallback: (context) => Center(
                        child: Text('لا يوجد بيانات'),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 26,
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Center(
                  child: Text(
                    "﴾ وَأَحۡسِنُوٓاْۚ إِنَّ ٱللَّهَ يُحِبُّ ٱلۡمُحۡسِنِينَ ﴿",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ),
              ),
              SizedBox(
                height: 26,
              ),
              BlocBuilder<ProjectCubit, ProjectState>(
                builder: (context, state) {
                  // print( ProjectCubit.get(context).countPersonModel);

                  return ConditionalBuilder(
                    condition:
                        ProjectCubit.get(context).countPersonModel != null &&
                            ProjectCubit.get(context).countPersonModel!.data != null,
                    builder: (context) => YosrCount(
                        ProjectCubit.get(context).countPersonModel,
                        ProjectCubit.get(context).countMoneyModel,
                        ProjectCubit.get(context).countDepositModel,
                        context),
                    fallback: (context) => Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              //Count Yosr

              //
              SizedBox(
                height: 26,
              ),
              Center(
                child: Text(
                  '﴾ لَن تَنَالُوا الْبِرَّ حَتَّىٰ تُنفِقُوا مِمَّا تُحِبُّونَ ۚ﴿',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel(
      DataPost dataPost, BuildContext context, int carouselIndex) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Text('Carousel $carouselIndex'),
        SizedBox(
          height: 280.0,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: PageView.builder(
              // store this controller in a State to save the carousel scroll position
              controller: PageController(viewportFraction: 0.8),
              itemBuilder: (BuildContext context, itemIndex) {
                return _buildCarouselItem(
                    ProjectCubit.get(context).postModel!.data![itemIndex],
                    context,
                    carouselIndex,
                    itemIndex);
              },
              itemCount: ProjectCubit.get(context).postModel!.data!.length,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildCarouselItem(DataPost dataPost, BuildContext context, int carouselIndex, int itemIndex) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
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
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.green.shade100),
              borderRadius: BorderRadius.all(Radius.circular(9.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  Expanded(
                    child: dataPost.imagePost!.isEmpty
                        ? Image.asset('assets/images/yosrlogo.jpg')
                        : FadeInImage.assetNetwork(
                            placeholder: "assets/images/yosrlogo.jpg",
                            fit: BoxFit.cover,
                            width: 290,
                            image: '${ImageLocal}' + dataPost.imagePost!,
                          ),
                  ),
                  SizedBox(
                      width: 270,
                      child: Text(
                        '${dataPost.title_post}',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.green.shade800),
                      )),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        children: [
                          Text(
                            'المبلغ المتبقي',
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${dataPost.amount} ريال يمني ',
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      )),
                      SizedBox(
                        width: 100,
                      ),
                      Expanded(
                          child: ButtonYOSR(
                        text: 'تبرع الان',
                        function: () {
                         late var bk_token = CacheHelper.GetData(key: 'bk_id');
                          bool? bank_data =
                              CacheHelper.GetData(key: 'bank_data');
                        late  var user_id = CacheHelper.GetData(key: 'id');

                          if (bank_data != null) {
                            if (bk_token != null) {
                              if (ProjectCubit.get(context).isShowSheetShown) {
                                if (FormKey.currentState!.validate()) {
                                  // cubit.InsertToDatabase(
                                  //   title: titlecontroller.text,
                                  //   date: datecontroller.text,
                                  //   time: timecontroller.text,);
                                }
                              } else {
                                ScafoldKey.currentState!.showBottomSheet(
                                      (context) => Container(
                                        padding: EdgeInsets.all(20.0),
                                        color: Colors.grey[200],
                                        child: Form(
                                          key: FormKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextFormField(
                                                controller: paycontroller,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'الرجاءأدخل المبلغ الذي تريد التبرع به';
                                                  }
                                                  return null;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText:
                                                      'أدخل المبلغ الذي تريد التبرع به',
                                                  prefixIcon: Icon(Icons.money),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30.0,
                                              ),
                                              ButtonYOSR(
                                                  function: () {
                                                    if (FormKey.currentState!
                                                        .validate()) {
                                                      AwesomeDialog(
                                                        context: context,
                                                        dialogType:
                                                            DialogType.success,
                                                        headerAnimationLoop:
                                                            false,
                                                        animType:
                                                            AnimType.rightSlide,
                                                        title:
                                                            'هل أنت متأكد من أجرى العملية ؟',
                                                        desc: '',
                                                        btnOkOnPress: () {
                                                          ProjectCubit.get(
                                                                  context)
                                                              .paymentFun(
                                                            bk_id: bk_token,
                                                            user_id: user_id,
                                                            amount:
                                                                paycontroller
                                                                    .text,
                                                            post_id: dataPost
                                                                .postId!,
                                                          );
                                                          Navigator.pop(
                                                              context);
                                                          final snackBar =
                                                              SnackBar(
                                                            backgroundColor:
                                                                MyColors.green,
                                                            content: Text(
                                                                'العملية تمت بنجاح'),
                                                          );
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                        },
                                                        btnCancelOnPress: () {},
                                                      ).show();
                                                    }
                                                  },
                                                  text: 'تبرع'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ).closed.then((value) {
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
                      )),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget YosrCount(
          CountPersonModel? countPersonModel,
          CountMoneyModel? countMoneyModel,
          CountDepositModel? countDepositModel,
          BuildContext context) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.green.shade100),
          borderRadius: BorderRadius.all(Radius.circular(9.0)),
        ),
        child: Column(
          children: [
            Center(
              child: Text(
                'يسر في أرقام',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'اجمالي التبرعات',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent),
              ),
            ),
            Center(
              child: Text(
                '${countMoneyModel!.data} R.Y',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.green),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'عدد المستفيدين من البرامج الخيرية والتنموية',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent),
              ),
            ),
            Center(
              child: Text(
                '${countPersonModel!.data}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'عدد عمليات التبرع',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent),
              ),
            ),
            Center(
              child: Text(
                '${countDepositModel!.data}',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.green),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      );
}
