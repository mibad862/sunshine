import 'package:flutter/material.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/view/ipad14.dart';

class Ipad13 extends StatelessWidget {
  const Ipad13({super.key});

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
      MaterialPageRoute(builder: (context) => Ipad14())
    );
  },
),

         SizedBox(height: 20.0,),
         Text('EMERGENCY CALL OUT',style: TextStyle(fontSize: 36.0,fontWeight: FontWeight.bold),),
         SizedBox(height: 20.0,),
         const Row(children: [
          SizedBox(width: 40.0,),
          Text("Have you been called out for a specific line?",style: TextStyle(fontSize: 28.0,color: Colors.green),),
         ],),
          const Row(children: [
          SizedBox(width: 40.0,),
          Text("[select \"No\" if you've been directed to a multi-line station]",style: TextStyle(fontSize: 28.0,color: Colors.green),),
         ],),
         const SizedBox(height: 20.0,),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
           SizedBox(),
            MoreButtons(func: () {  }, buttonText: 'NO',),
             
            MoreButtons(func: () {  }, buttonText: 'YES',),
            SizedBox(),
            
          ],
         ),
      
      SizedBox(height: MediaQuery.sizeOf(context).height*.35,),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
      
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
           MoreButtons(buttonText: "Next", func: (){})
      
          ],
        ),
      ),
      SizedBox(height: 30.0,),
      
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
