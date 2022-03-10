import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/RegisterCubit/RegisterCubit.dart';
import 'package:social_app/cubits/RegisterCubit/RegisterStates.dart';
import 'package:social_app/modules/Screens/homeLayout.dart';
import 'package:social_app/network/local/cashe_Helper.dart';
import 'package:social_app/sharred/components.dart';

class registerScreen extends StatelessWidget {



  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is RegisterSuccessState){
            if(state.Register_model.status!){
              print(state.Register_model.message);
              print(state.Register_model.data!.token);
              cashHelper.saveData(
                key: cashHelper.getDataShare(key: 'token'),
                value: state.Register_model.data!.token,
              ).then((value) {
                navigateAndFinish(
                  context,
                  homeLayout(),
                );
              });

            }
            else{
              showToast(
                  message:state.Register_model.message!,
                  state: toastStates.ERROR
              );
            }
          }

        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: Text('Salla'),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate:(String value){
                            if(value.isEmpty){
                              return('it must not be empty');
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person),
                      SizedBox(height: 20,),

                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate:(String value){
                            if(value.isEmpty){
                              return('it must not be empty');
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined),
                      SizedBox(height: 20,),

                      defaultFormField(
                          controller:passwordController,
                          type: TextInputType.visiblePassword,
                          validate:(String value){
                            if(value.isEmpty){
                              return('it must not be empty');
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.password),
                      SizedBox(height: 20,),
                      defaultFormField(
                          controller:phoneController,
                          type: TextInputType.name,
                          validate:(String value){
                            if(value.isEmpty){
                              return('it must not be empty');
                            }
                          },
                          label: 'Password',
                          prefix: Icons.phone_android),
                      SizedBox(height: 20,),
                      defaultButton(
                          function: (){
                            if(formKey.currentState!.validate()) {
                              RegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          text: 'Register')
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
