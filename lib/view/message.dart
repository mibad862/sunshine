import 'package:flutter/material.dart';
import 'package:sunshine_app/view/report_damage.dart';

class MessageOperator extends StatelessWidget {
  const MessageOperator({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Message From Operator",style: TextStyle(color: Colors.green,fontSize: 28.0,fontWeight: FontWeight.bold),),
          const SizedBox(height: 25.0,),
          const Text("BE ADVISED, THERE IS A PROTEST ON SPRING ST, THE PICKUP SPOT FOR PARLIMENT HAS BEEN MOVED TO LONSDALE ST",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 36.0),),
             const SizedBox(height: 160.0,),
GestureDetector(onTap: (){
Navigator.push(context,MaterialPageRoute(builder: (context)=> ReportDamage()));
},
child: Padding(
  padding: const EdgeInsets.symmetric(horizontal: 40.0),
  child: Container(
    color: Colors.pink,
    height: 60.0,
    child: const Center(child: Text("Acknowledge",style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold),),),
  ),
),
)
      
        ],
      ),
    );
  }
}