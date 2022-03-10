
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/searchCubit/searchStates.dart';
import 'package:social_app/models/searchModel.dart';
import 'package:social_app/network/Dio_Helper.dart';
import 'package:social_app/network/endPoint/endPoint.dart';
import 'package:social_app/network/local/cashe_Helper.dart';

class searchCubit extends Cubit<searchStates>{

      searchCubit(): super(searchInitialState());

      static searchCubit get(context)=>BlocProvider.of(context);

      searchModel? Searchmodel;

      void getSearch({
         required String? text
        }){
        emit(searchLoadingState());
        DioHelper.postData(
            url: SEARCH,
            token: cashHelper.getDataShare(key: 'token'),
            data:{
            'text':text
            }).then((value) {
              Searchmodel=searchModel.fromJson(value.data);
              print(value.data);
              emit(searchSuccessState());
        }).catchError((error){
          print(error.toString());
          emit(searchErrorState());
        });
      }
}