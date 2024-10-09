import 'package:flutter/material.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/view/ipad12.dart';

class CurrentdDamage extends StatelessWidget {
  const CurrentdDamage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle currentTextStyle = TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold);
    return  VisibilityWrapper(bodyScreen: Scaffold(
      appBar: AppBar(),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         
           Header(
  navigation: () {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => Ipad12())
    );
  },
),

          const SizedBox(height: 25.0,),
           const Text("Current Damage",style: TextStyle(fontSize: 36.0,fontWeight: FontWeight.bold),),
         SizedBox(height: 40.0,),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            furtherDetails(currentTextStyle: currentTextStyle, furtherText: 'Near Side (Left)', furtherChild: Text('Elec/Head LightLeft'),),
            furtherDetails(currentTextStyle: currentTextStyle, furtherText: 'Vehicle Front', furtherChild: Text(""),),
            furtherDetails(currentTextStyle: currentTextStyle, furtherText: 'Off Side (Right)', furtherChild: Text(''),),
            furtherDetails(currentTextStyle: currentTextStyle, furtherText: 'Internal', furtherChild: Text(''),),
          ],
         ),
         SizedBox(height: MediaQuery.sizeOf(context).height*.12,),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            furtherDetails(currentTextStyle: currentTextStyle, furtherText: 'Roof', furtherChild: Text(''),),
            furtherDetails(currentTextStyle: currentTextStyle, furtherText: 'Vehicle Rear', furtherChild: Text(''),),
            furtherDetails(currentTextStyle: currentTextStyle, furtherText: 'Bins (Internal Damage)', furtherChild: Text(''),),
          //  furtherDetails(currentTextStyle: currentTextStyle, furtherText: 'Internal',),
          ],
         ),
         SizedBox(height: MediaQuery.sizeOf(context).height*.3,),
      
          const Footer(isShowSettings: true)
        ],
      ),

    ));
  }
}

class furtherDetails extends StatelessWidget {
  String furtherText ;
  Widget furtherChild;
   furtherDetails({
    super.key,
    required this.furtherChild,
    required this.furtherText,
    required this.currentTextStyle,
  });

  final TextStyle currentTextStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(furtherText,style: currentTextStyle,),
        const SizedBox(height: 5.0,),
       Container(
        height: 5.0,
        width: 200.0,
        color: Colors.grey,
       ),
       SizedBox(height: 10.0,),
       furtherChild,
      
      ],
    );
  }
}