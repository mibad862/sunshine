import 'package:flutter/material.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/view/currentd_damage.dart';

class Ipad6 extends StatelessWidget {
  const Ipad6({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
   
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const SizedBox(height: 30.0,),
        Header(
  navigation: () {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => CurrentdDamage())
    );
  },
),

         const SizedBox(height: 20.0,),
        // Text('EMERGENCY CALL OUT',style: TextStyle(fontSize: 36.0,fontWeight: FontWeight.bold),),
         SizedBox(height: 20.0,),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          SizedBox(),
          Text("Release Vehicle",style: TextStyle(fontSize: 28.0),),
          SizedBox()
         ],),
      
         SizedBox(height: 40.0,),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            
            MoreButtons(func: () {  }, buttonText: 'AT DEPOT',),
              SizedBox(width: 40.0,),
            MoreButtons(func: () {  }, buttonText: 'SWAP WITH ANOTHER DRIVER',),
              SizedBox(width: 40.0,),
            MoreButtons(func: () {  }, buttonText: 'ANOTHER LOCATION',)
          ],
         ),
      
      SizedBox(height: MediaQuery.sizeOf(context).height*.44,),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MoreButtons(buttonText: "Cancel", func: (){}),
          SizedBox(width: 70.0,)
        ],
      ),
      SizedBox(height: 20.0,),
      
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
          child: Text(buttonText,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}
