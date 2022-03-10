import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/RegisterCubit/RegisterStates.dart';
import 'package:social_app/models/loginModel.dart';
import 'package:social_app/network/Dio_Helper.dart';
import 'package:social_app/network/endPoint/endPoint.dart';
import 'package:social_app/network/local/cashe_Helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{

  RegisterCubit(): super(RegisterInitialState());

  static RegisterCubit get(context)=>BlocProvider.of(context);

  loginModel? model;

  IconData suffix= Icons.visibility_outlined;
  bool isPassword=true;


  void changePassswordVisibility(){
    isPassword=isPassword;
    suffix=isPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(changePasswordState());
  }


  void userRegister({
    required String? name,
    required String? email,
    required String? phone,
    required String? password,
  })
  {
    emit(RegisterLoadinglState());
    DioHelper.postData(
      url: REGISTER,
      token: cashHelper.getDataShare(key: 'token'),
      data:
      {
        'name':name,
        'email': email,
        'phone':phone,
        'password': password,
      },
    ).then((value)
    {
      print(value.data);
      model=loginModel.fromJson(value.data);
      print(model!.status);
      print(model!.message);
      print(model!.data!.token);
      emit(RegisterSuccessState(model!));
    }).catchError((error)
    {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }
}