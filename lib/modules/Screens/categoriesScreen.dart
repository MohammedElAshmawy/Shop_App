

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/homeCubit/homeCubit.dart';
import 'package:social_app/cubits/homeCubit/homeStates.dart';
import 'package:social_app/models/categoriesModel.dart';
import 'package:social_app/sharred/components.dart';

class categoriesScreen extends StatelessWidget {
  const categoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Salla',
         style: TextStyle(
          color: Colors.black
         ),
        ),
       ),
      body: BlocConsumer<homeCubit,homeStates>(
        listener:(context,state){},
        builder:(context,state){
          return ListView.separated(
              itemBuilder:(context,index)=>buildCatItem(homeCubit.get(context).modelCategories!.data!.data[index]),
              separatorBuilder:(context,index)=>myDivider(),
              itemCount:homeCubit.get(context).modelCategories!.data!.data.length
          );
        },
      )
    );
  }

  Widget buildCatItem(dataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image:
        NetworkImage(model.image.toString()),
          height: 80,
          width: 80,
        ),
        SizedBox(width: 20,),
        Text(model.name.toString(),
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios)
      ],
    ),
  );
}

