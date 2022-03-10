
import 'package:social_app/models/favouritesModel.dart';
import 'package:social_app/models/loginModel.dart';
import 'package:social_app/models/loginModel.dart';

abstract class homeStates {}

class homeInitialState extends homeStates{}

class homeChangeBottomNav extends homeStates{}

class homeLoadingData extends homeStates{}
class homeSuccessState extends homeStates{}
class homeErrorState extends homeStates{}

class categoriesloadingState extends homeStates{}
class categoriesSuccessState extends homeStates{}
class categoriesErrorState extends homeStates{}
class changeFavouriteState extends homeStates{}

class favouriteSuccessState extends homeStates{
        final favouritesModel model;
         favouriteSuccessState(this.model);
}

class favouriteErrorState extends homeStates{}


class favouriteGetDataSuccessState extends homeStates{}
class favouriteGetDataLoadingState extends homeStates{}
class favouriteGetDataErrorState extends homeStates{}

class getUserDataSuccessState extends homeStates{
  final loginModel modelUser;
  getUserDataSuccessState(this.modelUser);
}

class getUserDataErrorState extends homeStates{}
class getUserDataLoadingState extends homeStates{}

class updateUserDataSuccessState extends homeStates{
  final loginModel modelUser;
  updateUserDataSuccessState(this.modelUser);
}

class updateUserDataErrorState extends homeStates{}
class updateUserDataLoadingState extends homeStates{}















