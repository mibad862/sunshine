import 'package:flutter/material.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/view/ipad16.dart';

class Ipad15 extends StatelessWidget {
  const Ipad15({super.key});

  @override
  Widget build(BuildContext context) {
    return VisibilityWrapper(bodyScreen: Scaffold(
     
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30.0,),
       Header(
  navigation: () {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => Ipad16())
    );
  },
),

        SizedBox(height: 20.0,),
        Text("Emergency Call Out",style: TextStyle(fontSize: 32.0,fontWeight: FontWeight.bold),),
        SizedBox(height: 20.0,),
        Row(
          children: [
            SizedBox(width: 80.0,),
            Text("Why metro line?",style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,color: Colors.green),),
          ],
        ),
        SizedBox(height: 20.0,),
        // Text("Break Due In <Next Break>",style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
       // SizedBox(height: MediaQuery.sizeOf(context).height*.2,),
           Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MoreButtons(buttonText: "Alamein", func: (){})
            , MoreButtons(buttonText: "Frankston", func: (){}),
             MoreButtons(buttonText: "Mernda", func: (){}),
              MoreButtons(buttonText: "Sunbury", func: (){}),
              //  MoreButtons(buttonText: "SHOW MAPS", func: (){})
      
          ],
        ),
        SizedBox(height: 20.0,),
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MoreButtons(buttonText: "Belgrave", func: (){})
            , MoreButtons(buttonText: "Glen Wav.", func: (){}),
             MoreButtons(buttonText: "Pakenham", func: (){}),
              MoreButtons(buttonText: "Upfield", func: (){}),
              //  MoreButtons(buttonText: "SHOW MAPS", func: (){})
      
          ],
        ),
        SizedBox(height: 20.0,),
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MoreButtons(buttonText: "Craigieburn", func: (){})
            , MoreButtons(buttonText: "Hurstbridge", func: (){}),
             MoreButtons(buttonText: "Sandringham", func: (){}),
              MoreButtons(buttonText: "Werribee", func: (){}),
              //  MoreButtons(buttonText: "SHOW MAPS", func: (){})
      
          ],
        ),
        SizedBox(height: 20.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MoreButtons(buttonText: "Flem. Race", func: (){})
            , MoreButtons(buttonText: "Lilydale", func: (){}),
             MoreButtons(buttonText: "Stony Point", func: (){}),
              MoreButtons(buttonText: "Williamstown", func: (){}),
              //  MoreButtons(buttonText: "SHOW MAPS", func: (){})
      
          ],
        ),
        const SizedBox(height: 100.0,),
        // SizedBox(height: MediaQuery.sizeOf(context).height*.24,),
        
        const Footer(isShowSettings: true)
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
