import 'package:flutter/material.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/view/message.dart';

class ReportDamage extends StatelessWidget {
  const ReportDamage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body:  Stack(
        children: [
          Align(alignment: Alignment.topCenter,child:   Header(
  navigation: () {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => const MessageOperator())
    );
  },
),),
        
         const Column(
        
           children: [
            SizedBox(height: 40.0,),
             Center(child: Text("Report Damage",style: TextStyle(fontSize: 36.0,fontWeight: FontWeight.bold),)),
           ],
         ),
          const Positioned(
          bottom: 0,
          right: 0,
          left: 0,
            child: Footer(isShowSettings: true))
        ],
      ),
    );
  }
}