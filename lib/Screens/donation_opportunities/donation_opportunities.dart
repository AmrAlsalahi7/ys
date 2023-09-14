import 'package:flutter/material.dart';
import 'package:ys/Screens/donation_opportunities/posts_all/posts_foregat.dart';
import 'package:ys/Screens/donation_opportunities/posts_all/posts_teasrt.dart';
import 'package:ys/shard/common/myColors.dart';

import 'posts_all/posts_project.dart';

class projects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor:MyColors.green,
              elevation: 0,
              bottom: TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: Colors.white),
                  tabs: [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("المشاريع"),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("تيسرت"),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("فرجت"),
                      ),
                    ),
                  ]),
            ),
            body: TabBarView(
                children: [
           ProjectPosts(),
            TeasrtPosts(),
             ForegatPosts(),

                ]),
          )),
    );
  }
}

