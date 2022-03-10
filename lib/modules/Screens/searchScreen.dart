import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/homeCubit/homeStates.dart';
import 'package:social_app/cubits/searchCubit/searchCubit.dart';
import 'package:social_app/cubits/searchCubit/searchStates.dart';
import 'package:social_app/sharred/components.dart';

class searchScreen extends StatelessWidget{
  var formKey=GlobalKey<FormState>();
  var searchController=TextEditingController();
  @override

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>searchCubit(),
      child: BlocConsumer<searchCubit,searchStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text('Search'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                    controller:searchController,
                    type: TextInputType.text,
                    label: 'Search',
                    prefix: Icons.search,
                    onSubmit:(String text){
                      searchCubit.get(context).getSearch(text:text);

                    }
                  ),
                  SizedBox(height: 10,),
                  if(state is searchLoadingState)
                  LinearProgressIndicator(),
                  SizedBox(height: 20,),
                  defaultButton(function: (){
                    searchCubit.get(context).getSearch(text:searchController.text);
                  },
                      text: 'search'
                  ),

                  SizedBox(height: 20,),
                  if(state is searchSuccessState)
                  Expanded(
                    child: ListView.separated(
                        itemBuilder:(context,index)=>buildListProduct(searchCubit.get(context).
                        Searchmodel!.data!.data![index],context),
                        separatorBuilder:(context,index)=>myDivider(),
                        itemCount:searchCubit.get(context).Searchmodel!.data!.data!.length
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }



}