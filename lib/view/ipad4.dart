import 'package:flutter/material.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/view/ipad6.dart';

class Ipad4 extends StatelessWidget {
  const Ipad4({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.0,),
        Header(
  navigation: () {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => Ipad6())
    );
  },
),

         SizedBox(height: 20.0,),
         Text('EMERGENCY CALL OUT',style: TextStyle(fontSize: 36.0,fontWeight: FontWeight.bold),),
         SizedBox(height: 20.0,),
         Row(children: [
          SizedBox(width: 40.0,),
          Text("Customers?",style: TextStyle(fontSize: 28.0,color: Colors.green),),
         ],),
         SizedBox(height: 20.0,),
         Row(
          children: [
            SizedBox(width: 80.0,),
            MoreButtons(func: () {  }, buttonText: 'V/Line',),
              SizedBox(width: 40.0,),
            MoreButtons(func: () {  }, buttonText: 'Metro',),
              SizedBox(width: 40.0,),
            MoreButtons(func: () {  }, buttonText: 'Yarra Trams',)
          ],
         ),
      
      SizedBox(height: MediaQuery.sizeOf(context).height*.52,),
      
         Footer(isShowSettings: true)
        ],
      ),

    );
  }
}
class MoreButtons extends StatelessWidget {
  final VoidCallback func; // Use VoidCallback for the correct type
String buttonText;
  MoreButtons({
    required this.buttonText,
    required this.func,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func, // Now it's the correct type
      child: Container(
        height: 80.0,
        width: 220.0,
        decoration: BoxDecoration(
          color: Colors.yellow.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Text(buttonText,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
