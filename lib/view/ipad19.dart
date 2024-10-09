import 'package:flutter/material.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/view/ipad21.dart';

class Ipad19 extends StatelessWidget {
  const Ipad19({super.key});

  @override
  Widget build(BuildContext context) {
    return VisibilityWrapper(bodyScreen: Scaffold(
      appBar: AppBar(),
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Header(
  navigation: () {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => Ipad21())
    );
  },
),

        SizedBox(height: 20.0,),
        Text("Emergency Call Out",style: TextStyle(fontSize: 32.0,fontWeight: FontWeight.bold),),
        SizedBox(height: 20.0,),
        Text("On standby at <Station Name> since <Time StandBy Commenced>",style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
        SizedBox(height: 20.0,),
        Text("Break Due In <Next Break>",style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
        SizedBox(height: MediaQuery.sizeOf(context).height*.2,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MoreButtons(buttonText: "I'VE BEEN RELEASED", func: (){})
            , MoreButtons(buttonText: "RELOCATE", func: (){}),
             MoreButtons(buttonText: "START BREAK", func: (){}),
              MoreButtons(buttonText: "START A SERVICE", func: (){}),
               MoreButtons(buttonText: "SHOW MAPS", func: (){})
      
          ],
        ),
         SizedBox(height: MediaQuery.sizeOf(context).height*.24,),
        
        Footer(isShowSettings: true)
      ],
          ),

    ));
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
        width: 180.0,
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
