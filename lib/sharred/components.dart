


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/cubits/homeCubit/homeCubit.dart';
import 'package:social_app/modules/Screens/shop_login.dart';
import 'package:social_app/network/local/cashe_Helper.dart';

void navigateTo (context,widget)=>
    Navigator.push(context
        , MaterialPageRoute(
          builder:(context)=>widget(
          ),

        ));

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
    child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);



void navigateAndFinish(context,widget)=>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context)=>widget),

            (route) {
              return false;
            });

void signOut(context){
  cashHelper.removeData(key: 'token').then((value) {
    if(value){
      navigateAndFinish(context,
          shopLoginScreen());
    }
  });
}




Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: (){
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );


Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: (){
        function();
      },
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isPassword = false,
   Function? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted:(s)=> onSubmit,
      onChanged:(s)=>  onChange,
      onTap:()=>  onTap,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
             onPressed:()=> suffixPressed,

             icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );



void showToast({
  required String message,
  required toastStates state
})=>Fluttertoast.showToast(
    msg:message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseColorState(state),
    textColor: Colors.red,
    fontSize: 16.0
);

enum toastStates{SUCCESS,ERROR,WARNING}

Color chooseColorState(toastStates state){
  Color color;
  switch(state){
    case toastStates.SUCCESS:
      color=Colors.green;
      break;

    case toastStates.ERROR:
      color=Colors.red;
      break;

    case toastStates.WARNING:
      color=Colors.yellow;
      break;
  }
  return color;

}


Widget buildListProduct(model,context)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120,
          width: 120,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [

                  Image(

                    image: NetworkImage(model!.image.toString()),
                    width: double.infinity,

                    height: 200,
                  ),

                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('DISCOUNT',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10
                    ),
                  ),

                ),
            ],
          ),
        ),
        SizedBox(width: 20,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.blue
                    ),
                  ),
                  SizedBox(width: 5,),
                  if(1<0)
                    Text(
                      model.oldPrice.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),

                    ),
                  Spacer(),
                  IconButton(
                      onPressed: (){
                        homeCubit.get(context).changeFavourites(model.id!.toInt());
                      },

                      icon: CircleAvatar(
                        backgroundColor:Colors.blue,
                        radius: 15,
                        child: Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.white,
                          size: 12,),
                      )
                  )
                ],
              ),
            ],
          ),
        ),

      ],
    ),
  ),
);





















