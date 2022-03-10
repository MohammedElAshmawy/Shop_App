import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/homeCubit/homeStates.dart';
import 'package:social_app/cubits/searchCubit/searchStates.dart';
import 'package:social_app/models/categoriesModel.dart';
import 'package:social_app/models/favouriteModelData.dart';
import 'package:social_app/models/favouritesModel.dart';
import 'package:social_app/models/loginModel.dart';
import 'package:social_app/models/searchModel.dart';
import 'package:social_app/network/local/cashe_Helper.dart';
import 'package:social_app/sharred/components.dart';
import 'package:social_app/models/homeModel.dart';
import 'package:social_app/modules/Screens/categoriesScreen.dart';
import 'package:social_app/modules/Screens/favouritesScreen.dart';
import 'package:social_app/modules/Screens/productScreen.dart';
import 'package:social_app/modules/Screens/settingsScreen.dart';
import 'package:social_app/network/Dio_Helper.dart';
import 'package:social_app/network/endPoint/endPoint.dart';
import 'package:social_app/sharred/constants.dart';

class homeCubit extends Cubit<homeStates>{

    homeCubit(): super(homeInitialState());
    static homeCubit get(context)=>BlocProvider.of(context);
    List<BottomNavigationBarItem> BottomNavigationBar=[
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourite'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: 'Categories'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings'
        ),
    ];

    int currentIndex=0;
    List<Widget> bottomScreens=[
        productScreen(),
        favouritesScreen(),
        categoriesScreen(),
        settingsScreen(),
    ];
    void changeBottomNav(int index){
        currentIndex=index;
        emit(homeChangeBottomNav());
    }

    Map<dynamic,dynamic>? favourites={};
    homeModel? model;



    void getHomeData(){

        emit(homeLoadingData());
        DioHelper.getData(
            url:HOME,
            token: token,
        ).then((value) {
            model=homeModel.formJson(value.data);
           // printFullText(model!.data!.banners[0].image.toString());
            model!.data!.products.forEach((element) {
                favourites!.addAll(({element.id: element.in_favourite}));
            });
            print(favourites.toString());
            emit(homeSuccessState());
        }).catchError((error){
            print(error.toString());
            emit(homeErrorState());
        });
    }

    categoriesModel? modelCategories;

    void getCategoriesData(){

        DioHelper.getData(
            url:GET_CATEGORIES,
            token:cashHelper.getDataShare(key: 'token'),
        ).then((value) {
            modelCategories=categoriesModel.fromJson(value.data);
            emit(categoriesSuccessState());
        }).catchError((error){
            print(error.toString());
            emit(categoriesErrorState());
        });
    }

    favouritesModel? favouritemodel;

    void changeFavourites(int productId){
        favourites![productId]=!favourites![productId];
        emit(changeFavouriteState());
        DioHelper.postData(
            url: FAVOURITES,
            token: cashHelper.getDataShare(key: "token"),
            data: {'product_id':productId}
            ).then((value)  {
             favouritemodel=favouritesModel.fromJson(value.data);
             emit(favouriteSuccessState(favouritemodel!));
             print(value.data);
            if(!favouritemodel!.status!){
                favourites![productId]=!favourites![productId];
            }else
                {getFavouriteData();
            }
            }).catchError((error){
            favourites![productId]=!favourites![productId];
            emit(favouriteErrorState());
            print(error.toString());
        });
    }

    FavoritesModel? favoriteDataModel;

    void getFavouriteData(){
        emit(favouriteGetDataLoadingState());
        DioHelper.getData(
            url:FAVOURITES,
            token: cashHelper.getDataShare(key: 'token'),
        ).then((value) {
            favoriteDataModel=FavoritesModel.fromJson(value.data);
            printFullText(value.data.toString());
            emit(favouriteGetDataSuccessState());
        }).catchError((error){
            print(error.toString());
            emit(favouriteGetDataErrorState());
        });
    }

    loginModel? userModel;
    void getUserData(){
        emit(getUserDataLoadingState());
        DioHelper.getData(
            url:PROFILE,
            token: cashHelper.getDataShare(key: 'token'),
            ).then((value) {
            userModel=loginModel.fromJson(value.data);
            printFullText(value.data.toString());
            print(userModel!.data!.name);
            emit(getUserDataSuccessState(userModel!));
        }).catchError((error){
            print(error.toString());
            emit(getUserDataErrorState());
        });
    }


    void updateUserData({
    required String? name,
    required String? email,
    required String? phone,
     })
    {
        emit(updateUserDataLoadingState());
        DioHelper.putData(
            data: {
             "name":name,
             'email':email,
             'phone':phone
            },
            url:UPDATE_PROFILE,
            token: cashHelper.getDataShare(key: 'token'),
        ).then((value) {
            userModel=loginModel.fromJson(value.data);
            printFullText(value.data.toString());
            print(userModel!.data!.name);
            emit(updateUserDataSuccessState(userModel!));
        }).catchError((error){
            print(error.toString());
            emit(updateUserDataErrorState());
        });
    }

















}



