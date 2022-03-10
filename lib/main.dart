import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/blocObserver/bloc_0bserver.dart';
import 'package:social_app/cubits/homeCubit/homeCubit.dart';
import 'package:social_app/cubits/homeCubit/homeStates.dart';
import 'package:social_app/modules/Screens/homeLayout.dart';
import 'package:social_app/modules/Screens/productScreen.dart';
import 'package:social_app/modules/Screens/onBoardingScreen.dart';
import 'package:social_app/modules/Screens/shop_login.dart';
import 'package:social_app/network/Dio_Helper.dart';
import 'package:social_app/network/local/cashe_Helper.dart';
import 'package:social_app/styles/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await cashHelper.init();

  bool? onBoarding=cashHelper.getDataShare(key: 'onBooarding');
  String? token=cashHelper.getDataShare(key: 'token');
  print(token);
  Widget widget;

  if(onBoarding !=null){
    if(token!=null)
      widget=homeLayout();
    else
      widget=shopLoginScreen();
    }
    else
    widget=onBoarding_Screen();

   Bloc.observer = MyBlocObserver();

  runApp(MyApp(
    startWidget:widget,
  ));
  }

  class MyApp extends StatelessWidget {
   //variables place
  final Widget startWidget;
  const MyApp({Key? key,
    required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {


             return BlocProvider(
               create: (BuildContext context)=>homeCubit()..
                 getHomeData()..
                 getCategoriesData()..
                 getFavouriteData()..
                 getUserData(),
               child: BlocConsumer<homeCubit,homeStates>(
                 listener: (context,state){},
                 builder: (context,state){

                     return MaterialApp(
                       debugShowCheckedModeBanner: false,
                       home: startWidget,
                     );

                 },

               ),
             );
           }
      }


