
import 'package:bot_toast/bot_toast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/cubits/homeCubit/homeCubit.dart';
import 'package:social_app/cubits/homeCubit/homeStates.dart';
import 'package:social_app/models/categoriesModel.dart';
import 'package:social_app/models/homeModel.dart';
import 'package:social_app/modules/Screens/searchScreen.dart';
import 'package:social_app/sharred/components.dart';
import 'package:social_app/modules/Screens/settingsScreen.dart';

class productScreen extends StatelessWidget {
  const productScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

        return BlocConsumer<homeCubit,homeStates>(
          listener:(context,state){
            //if(state is favouriteSuccessState){
              //if(!state.model!.status!){
              //}
            //}
          },

          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                title:Text('Salla',
                style: TextStyle(
                  color: Colors.black
                ),),
                backgroundColor: Colors.white,
                actions: [
                  IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>searchScreen()));
                      },
                      icon: Icon(Icons.search,
                      color: Colors.black
                        ,))
                ],
              ),

              body:
              ConditionalBuilder(
                  condition:homeCubit.get(context).model!=null && homeCubit.get(context).modelCategories!=null,
                  builder:(context)=>productBuilder(homeCubit.get(context).model,
                      homeCubit.get(context).modelCategories,context),
                  fallback:(context)=>Center(child: CircularProgressIndicator())
              ),
            );
          },
        );

      }
     Widget productBuilder(homeModel? model,categoriesModel? categoriesModel,context )=>SingleChildScrollView(
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             CarouselSlider(
              items:model!.data!.banners.map((e) =>Image(
                  image: NetworkImage('${e.image}'),
                  width: double.infinity,
                  fit: BoxFit.cover,
              ), ).toList(),
             options: CarouselOptions(
                 height: 250.0,
                 initialPage: 0,
                 enableInfiniteScroll: true,
                 viewportFraction: 1,
                 reverse: false,
                 autoPlay: true,
                 autoPlayInterval: Duration(seconds: 3),
                 autoPlayAnimationDuration: Duration(seconds: 1),
                 scrollDirection: Axis.horizontal

             )
          ),
             SizedBox(height: 5,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 11),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text('Categories',
                     style: TextStyle(
                       fontSize: 24,
                       fontWeight: FontWeight.bold
                      ),
                     ),
                   SizedBox(height: 6,),
                   Container(
                     height: 100,
                     child: ListView.separated(
                       scrollDirection: Axis.horizontal,
                         itemBuilder:(context,index)=>buildCategoriesItem(categoriesModel!.data!.data[index]),
                         separatorBuilder:(context,index)=>SizedBox(width: 20,),
                         itemCount: categoriesModel!.data!.data.length),
                   ),
                   SizedBox(height: 15,),
                   Text('New Products',
                     style: TextStyle(
                         fontSize: 24,
                         fontWeight: FontWeight.bold
                     ),
                   ),
                 ],
               ),
             ),
             SizedBox(height: 5,),
             GridView.count(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 crossAxisCount: 2,
                 crossAxisSpacing:1,
                 mainAxisSpacing: 1,
                  childAspectRatio:1/1.8,
                  children:
                    List.generate(model.data!.products.length,
                            (index) =>buildGridProduct(model.data!.products[index],context)
                      ),
             ),
         ],
        ),
      );

     Widget buildCategoriesItem(dataModel? model)=>Stack(
       alignment: AlignmentDirectional.bottomStart,
       children: [
         Image(image:
         NetworkImage(model!.image.toString()),
           height: 100,
           width: 100,
           fit: BoxFit.cover,
         ),

         Container(
           color: Colors.black.withOpacity(.6),
           width: 100,
           child: Text(model.name.toString(),
             maxLines: 1,
             overflow: TextOverflow.ellipsis,
             textAlign: TextAlign.center,
             style: TextStyle(
                 color: Colors.white
             ),
           ),
         ),
       ],

     );

     Widget buildGridProduct(productsModel? model,context)=> Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image:NetworkImage(model!.image.toString()),
                  width: double.infinity,
                  height: 200,
          ),
                if(model.discount!=0)
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
            
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
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
                      if(model.discount!=0)
                      Text(
                        model.old_price.toString(),
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
                            backgroundColor: homeCubit.get(context).favourites![model.id]?Colors.blue:Colors.grey,
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
             );

    }










