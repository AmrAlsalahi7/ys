// import 'package:card_swiper/card_swiper.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
// import 'package:quran/quran.dart' as quran;

//CustomAppBare
Widget CustomAppBare({
  required String text,
}) =>
    AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Row(
        children: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.person, color: Colors.green)),
          // IconButton(onPressed: (){}, icon: Icon(Icons.shopping_basket)),
        ],
      ),
      title: Container(
          width: double.infinity, height: 30, child: Image.asset(text)),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      ],
    );

//CustomSwaper
Widget CustomSwaper(
  List sweperImage,
) {
  return Container(
    height: 250,
    width: double.infinity,
    child: Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 90.0),
          child: Image.asset(
            sweperImage[index],
            fit: BoxFit.cover,
          ),
        );
      },

      // viewportFraction: 0.8,

      // scale: 0.9,

      autoplay: true,

      // itemWidth: 300.0,

      // itemHeight: 300.0,

      itemCount: sweperImage.length,

      pagination: SwiperPagination(),

      control: SwiperControl(),

      allowImplicitScrolling: true,
    ),
  );
}

//CustomTapBar
Widget CustomTapBar() {
  return TabBar(
    unselectedLabelColor: Colors.white,
    indicatorSize: TabBarIndicatorSize.label,
    indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(50), color: Colors.green),
    tabs: [
      Container(
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.lightGreen, width: 1)),
        child: Center(
          child: Text(
            "فرجت",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      Container(
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.lightGreen, width: 1)),
        child: Center(
          child: Text(
            "تيسرت",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      Container(
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.lightGreen, width: 1)),
        child: Center(
          child: Text(
            "المشاريع",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    ],
  );
}

//  navigateTo
void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

//remove page when you click button or any tools (called this function)
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);
// showProgressIndicator
void showProgressIndicator(BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    ),
  );

  showDialog(
    barrierColor: Colors.white.withOpacity(0),
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return alertDialog;
    },
  );
}

Widget ButtonYOSR({
  double width = double.infinity,
  Color? backgroundcolor,
  Color? colortxt,
  double radius = 0.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      child: ElevatedButton(
        onPressed:(){
          function();
        },
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: colortxt,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundcolor,
      ),
    );

Widget TextBoxYOSR({
  required TextEditingController textcontroller,
  TextInputType? type,
  Function? onsubmit,
  Function? validate,
  required String lable,
  required IconData prefixicon,
  IconData? suffix,
  bool isPass = false,
  double? height,
  double? width,
  Color color = Colors.black,
}) =>
    Container(
      height: height,
      width: width,
      child: TextFormField(
        keyboardType: type,
        validator: (v){
          validate!(v);
        },
        onChanged:(s){
          onsubmit!(s);
        },
        obscureText: isPass,
        decoration: InputDecoration(
          labelText: lable,
          hintStyle: TextStyle(fontSize: 5),
          labelStyle: TextStyle(color: Colors.black, fontSize: 15),
          prefixIcon: Icon(prefixicon),
          suffixIcon: Icon(suffix),
          // border: OutlineInputBorder(),
          isDense: true,
          contentPadding: EdgeInsets.all(8),
          // focusedBorder:
          // OutlineInputBorder(borderSide: BorderSide(color: color)),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
        controller: textcontroller,
      ),
    );

Widget myDivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.deepPurple,
    );
