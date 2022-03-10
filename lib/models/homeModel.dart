class homeModel{
  bool? status;
  homeDataModel? data;


   homeModel.formJson(Map<String,dynamic> json){
     status=json['status'];
     data=homeDataModel.formJson(json['data']);
   }
}


class homeDataModel{

  List<bannerModel> banners=[];
  List<productsModel> products=[];

  homeDataModel.formJson(Map<String,dynamic> json){
    json['banners'].forEach((element)
    {
      banners.add(bannerModel.formJson(element));
    });

    json['products'].forEach((element)
    {
      products.add(productsModel.formJson(element));
    });
  }
}

class bannerModel{
  int? id;
  String? image;
  bannerModel.formJson(Map<String , dynamic> json){
     id=json['id'];
     image=json['image'];
  }
}

class productsModel{
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;
  bool? in_favourite;
  bool? in_cart;

  productsModel.formJson(Map<String,dynamic> json){
      id=json['id'];
      price=json['price'];
      old_price=json['old_price'];
      discount=json['discount'];
      image=json['image'];
      name=json['name'];
      in_favourite=json['in_favorites'];
      in_cart=json['in_cart'];
  }
}










