

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/homeCubit/homeCubit.dart';
import 'package:social_app/cubits/homeCubit/homeStates.dart';
import 'package:social_app/models/favouriteModelData.dart';
import 'package:social_app/sharred/components.dart';

class favouritesScreen extends StatelessWidget {
  const favouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salla',style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
      ),

      body:BlocConsumer<homeCubit,homeStates>(
        listener:(context,state){},
        builder:(context,state){
          return ConditionalBuilder(
            condition: state is!favouriteGetDataLoadingState,
            builder:(context)=>ListView.separated(
                itemBuilder:(context,index)=>buildFavItem(homeCubit.get(context).favoriteDataModel!
                    .data!.data![index].product,context),
                separatorBuilder:(context,index)=>myDivider(),
                itemCount:homeCubit.get(context).favoriteDataModel!.data!.data!.length
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget buildFavItem(model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: 120,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image:NetworkImage(model!.image.toString()),
                  width: double.infinity,
                  
                  height: 200,
                ),
                if(model.discount!.toInt()>0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('DISCOUNT',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 10
                      ),
                    ),

                  ),
              ],
            ),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.blue
                      ),
                    ),
                    SizedBox(width: 5,),
                    if(1<0)
                      Text(
                        model.oldPrice.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),

                      ),
                    Spacer(),
                    IconButton(
                        onPressed: (){
                          homeCubit.get(context).changeFavourites(model.id!.toInt());
                        },

                        icon: CircleAvatar(
                          backgroundColor:Colors.blue,
                          radius: 15,
                          child: Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white,
                            size: 12,),
                        )
                    )
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    ),
  );
}









