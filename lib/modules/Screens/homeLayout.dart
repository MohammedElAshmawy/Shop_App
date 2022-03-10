
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/homeCubit/homeCubit.dart';
import 'package:social_app/cubits/homeCubit/homeStates.dart';
import 'package:social_app/sharred/components.dart';

class homeLayout extends StatelessWidget {
  const homeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit=homeCubit.get(context);
    return BlocConsumer<homeCubit,homeStates>(
      listener:(context,state){},
      builder: (context,state){
        return Scaffold(
          body:cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items:cubit.BottomNavigationBar,
            currentIndex: cubit.currentIndex,
            fixedColor: Colors.blue,
            unselectedLabelStyle: TextStyle(
              color: Colors.blue
            ),
            unselectedIconTheme:IconThemeData(
                color:Colors.grey
            ),
            showUnselectedLabels:true,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
          ),
        );
      },
    );
  }
}