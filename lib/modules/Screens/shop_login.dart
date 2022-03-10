
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/cubits/loginCubit/cubit_Login.dart';
import 'package:social_app/cubits/loginCubit/states_Login.dart';
import 'package:social_app/modules/Screens/homeLayout.dart';
import 'package:social_app/modules/Screens/productScreen.dart';
import 'package:social_app/modules/Screens/resgister_Screen.dart';
import 'package:social_app/sharred/components.dart';
import 'package:social_app/network/local/cashe_Helper.dart';

class shopLoginScreen extends StatelessWidget {

  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var formKey =GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) =>loginCubit(),
      child: BlocConsumer<loginCubit,loginStates>(
        listener:(context,state){
         if(state is loginSuccessState){
           if(state.login_model.status!){
             print(state.login_model.message);
             print(state.login_model.data!.token);
             cashHelper.saveData(
                 key: 'token',
                 value: state.login_model.data!.token,
             ).then((value) {
               navigateAndFinish(
                   context,
                   homeLayout(),
               );
             });
           }
           else if(state is loginErrorState){
             showToast(
                 message:state.login_model.message!,
                 state: toastStates.ERROR
             );
           }
          }
         },
        builder:(context,state)=>Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LOGIN'
                        ,style:TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text('login now to browse our hot offers'
                        ,style:TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 30,),
                      TextFormField(

                        validator:(value){
                          if(value!.isEmpty){
                            return('It must not be empty');
                          }
                          return null;
                        },
                        controller: emailController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 30,),
                      defaultFormField(
                          isPassword: loginCubit.get(context).isPassword,
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (String value){
                            return('It must not be empty');
                          },
                          label: 'Password',
                          prefix: Icons.password,
                          suffix: loginCubit.get(context).suffix,
                          suffixPressed:(){
                            loginCubit.get(context).changePassswordVisibility();
                          }
                      ),

                      SizedBox(height: 30,),
                      MaterialButton(
                        onPressed: (){
                          if(formKey.currentState!.validate()){
                            loginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        child: Text('login'),
                        color:Colors.blue,
                        minWidth: double.infinity,
                      ),

                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>registerScreen()));
                              },
                              child: Text('Dont\'t have an account ?',
                                style: TextStyle(
                                    color: Colors.black
                                ),)
                          ),
                          TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>registerScreen()));
                              },
                              child: Text('Register',
                                style: TextStyle(
                                    color: Colors.blue
                                ),)
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
