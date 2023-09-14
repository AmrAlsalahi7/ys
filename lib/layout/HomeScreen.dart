import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ys/shard/common/myColors.dart';
import 'package:ys/shard/cubits/homeCubit/cubit.dart';
import 'package:ys/shard/cubits/homeCubit/state.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final colorScheme = Theme.of(context).colorScheme;
          final textTheme = Theme.of(context).textTheme;
          var cubit = HomeCubit.get(context);

          return Scaffold(
              body: Center(
                child: cubit.bottomScreen.elementAt(cubit.selectedIndex),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label:('حسابي'),
                      backgroundColor:MyColors.green),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.widgets_outlined),
                      label:('فرص التبرع'),

                      backgroundColor:MyColors.green),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: ('الرئيسية'),
                      backgroundColor:MyColors.green),
                ],
                type: BottomNavigationBarType.shifting,
                currentIndex: cubit.selectedIndex,
                // selectedLabelStyle: textTheme.caption,
                // unselectedLabelStyle: TextStyle(color: Colors.white),
                showUnselectedLabels: true,
                onTap: cubit.changeBottom,
              ));
        });
  }
}

