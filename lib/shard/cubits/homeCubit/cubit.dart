import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ys/Screens/Profile/ProfileScreen.dart';
import 'package:ys/Screens/donation_opportunities/donation_opportunities.dart';
import 'package:ys/Screens/home/HomeTabBareVew/home.dart';
import 'package:ys/shard/cubits/homeCubit/state.dart';
class HomeCubit extends Cubit<HomeStates>
{

  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  final sweperImage = [
    'assets/images/yosrlogo.jpg',
    'assets/images/splash_1.png',
    'assets/images/splash_2.png'
  ];
  int selectedIndex = 2;

  List bottomScreen = [
    Profile(),
    projects(),
    HomeLayout(),
  ];

  void changeBottom(int index) {
    selectedIndex = index;
    emit(ChangeBottomNavIndexState());
  }
}