
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_app/sharred/components.dart';
import 'package:social_app/modules/Screens/shop_login.dart';
import 'package:social_app/network/local/cashe_Helper.dart';

class BoardingModel {
  late final String image;
  late final String title;
  late final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}


class onBoarding_Screen extends StatefulWidget {

  @override
  State<onBoarding_Screen> createState() => _onBoarding_ScreenState();
}

class _onBoarding_ScreenState extends State<onBoarding_Screen> {
  List<BoardingModel> boarding=[
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'on Board title 1',
        body: 'on board body 1'),
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'on Board title 2',
        body: 'on board body 2'),
    BoardingModel(
        image: 'assets/images/onboard_1.jpg',
        title: 'on Board title 3',
        body: 'on board body 3'),
    ];

  bool isLast=false;

  var boardController=PageController();

  void submit(){
     cashHelper.saveData(key: 'onBooarding', value: true).then((value) {
       if(value){
         navigateAndFinish(
             context,
             shopLoginScreen());
       }
     });


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                submit();
              },
              child: Text('SKIP'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index){
                  if(index==boarding.length-1){
                    setState(() {
                      isLast=true;
                    });

                  }else{
                    setState(() {
                      isLast=false;
                    });

                  }
                },
                itemBuilder: (context,index)=>buildItemOnboard(boarding[index]),
                itemCount:boarding.length ,

              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.orange,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: .5,
                    ),
                ),
                Spacer(),
                FloatingActionButton(
                    onPressed: (){
                      if(isLast){
                        submit();
                      }else{
                        boardController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }

                    },
                    child: Icon(Icons.arrow_forward_ios),

                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemOnboard(BoardingModel model) =>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
       ),
        Text('${model.title}',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
        SizedBox(height: 10,),
        Text('${model.body}',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
        SizedBox(height: 10,),
    ],
  );
}
