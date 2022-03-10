import 'package:social_app/models/loginModel.dart';

abstract class loginStates {}

class loginInitialState extends loginStates{}

class loginLoadinglState extends loginStates{}

class loginSuccessState extends loginStates{

  final loginModel login_model;

  loginSuccessState(this.login_model);
}

class loginErrorState extends loginStates{
  final String error;

  loginErrorState(this.error);
}
class changePasswordState extends loginStates{}