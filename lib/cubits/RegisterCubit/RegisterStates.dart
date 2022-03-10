
import 'package:social_app/models/loginModel.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates{}

class RegisterLoadinglState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{

  final loginModel Register_model;

  RegisterSuccessState(this.Register_model);
}

class RegisterErrorState extends RegisterStates{
  final String error;

  RegisterErrorState(this.error);
}
class changePasswordState extends RegisterStates{}
