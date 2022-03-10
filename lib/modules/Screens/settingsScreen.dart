
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/homeCubit/homeCubit.dart';
import 'package:social_app/cubits/homeCubit/homeStates.dart';
import 'package:social_app/sharred/components.dart';

class settingsScreen extends StatelessWidget {

  var formKey =GlobalKey<FormState>();
  var emailController =TextEditingController();
  var nameController =TextEditingController();
  var phoneController =TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<homeCubit,homeStates>(
      listener:(context,state){

      },
      builder:(context,state){
         var model=homeCubit.get(context).userModel;
         nameController.text= model!.data!.name!;
         emailController.text=model.data!.email!;
         phoneController.text=model.data!.phone!;
        return  ConditionalBuilder(
          condition: homeCubit.get(context).userModel!=null,
          builder: (context)=>Scaffold(
            appBar: AppBar(),
            body:Padding(

              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is updateUserDataLoadingState)
                    LinearProgressIndicator(),
                      SizedBox(height: 20,),
                      defaultFormField(
                        controller:nameController,
                        type: TextInputType.text,
                        validate:(String value){
                          if(value.isEmpty){
                            return('name must not be empty');
                          }
                        },
                        label: 'Name',
                        prefix:Icons.person),
                    SizedBox(height: 20,),
                    defaultFormField(
                        controller:emailController,
                        type: TextInputType.emailAddress,
                        validate:(String value){
                          if(value.isEmpty){
                            return('email must not be empty');
                          }
                        },
                        label: 'Email Adress',
                        prefix:Icons.email_outlined),
                    SizedBox(height: 20,),
                    defaultFormField(
                        controller:phoneController,
                        type: TextInputType.phone,
                        validate:(String value){
                          if(value.isEmpty){
                            return('phone must not be empty');
                          }
                        },
                        label: 'Phone',
                        prefix:Icons.phone_android),
                    SizedBox(height: 20),
                    defaultButton(function: (){
                      signOut(context);
                    },
                        text: 'Log out'),
                    SizedBox(height: 20),
                    defaultButton(function: (){
                       if(formKey.currentState!.validate()){
                          homeCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text);
                       }
                      },
                        text: 'Update')
                  ],
                ),
              ),
            ),
          ),
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }
}





