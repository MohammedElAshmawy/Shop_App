class favouritesModel{
  bool? status;
  String? message;


  favouritesModel.fromJson(Map<String,dynamic>json){

    status=json['status'];
    message=json['message'];
  }

}