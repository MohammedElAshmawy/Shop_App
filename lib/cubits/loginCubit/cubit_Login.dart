
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/loginCubit/states_Login.dart';
import 'package:social_app/models/loginModel.dart';
import 'package:social_app/network/Dio_Helper.dart';
import 'package:social_app/network/endPoint/endPoint.dart';

class loginCubit extends Cubit<loginStates>{
  
  loginCubit(): super(loginInitialState());

  static loginCubit get(context)=>BlocProvider.of(context);

  loginModel? model;

  IconData suffix= Icons.visibility_outlined;
  bool isPassword=true;


  void changePassswordVisibility(){
    isPassword=isPassword;
    suffix=isPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(changePasswordState());
  }

  void userLogin({
    required String? email,
    required String? password,
  })
  {
    emit(loginLoadinglState());
    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email': email,
        'password': password,
      },
    ).then((value)
    {
      model=loginModel.fromJson(value.data);
      print(model!.data!.token);
      emit(loginSuccessState(model!));
    }).catchError((error)
    {
      print(error.toString());
      emit(loginErrorState(error.toString()));
    });
  }
}