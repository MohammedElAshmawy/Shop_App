class loginModel{

 bool? status;
 String? message;
 userData? data;


  loginModel.fromJson(Map<String,dynamic> jason ){
   status=jason['status'];
   message=jason['message'];
   data=jason['data']!=null? userData.fromJson(jason['data']):null;

 }


}
class userData{

  int? id;
  String? email;
  String?  name;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  userData({
    this.id,
    this.email,
    this.name,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
});
  // NAMED CONSTRUCTOR
  userData.fromJson(Map<String,dynamic> jason ){
      id=jason['id'];
      email=jason['email'];
      name=jason['name'];
      phone=jason['phone'];
      image=jason['image'];
      points=jason['points'];
      credit=jason['credit'];
      token=jason['token'];

  }
}