import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/controller/datetime_controller.dart';
// Import the provider

class Header extends StatelessWidget {
  VoidCallback? navigation;
   Header({super.key,this.navigation});

  @override
  Widget build(BuildContext context) {
    TextStyle currentTextStyle = const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    );

   
    String currentDateTime = context.watch<DateTimeProvider>().currentDateTime;

    return Row(
       mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width*.30,
          child: Text("Sunshine Scenic Tours", style: currentTextStyle,textAlign: TextAlign.center,)),
        SizedBox(
           width: MediaQuery.sizeOf(context).width*.30,
          child: Text(currentDateTime, style: currentTextStyle,textAlign: TextAlign.center,)),
        SizedBox(
           width: MediaQuery.sizeOf(context).width*.30,
          child: Text("8446AO", style: currentTextStyle,textAlign: TextAlign.center,)),
          SizedBox(
            width: MediaQuery.sizeOf(context).width*.10,
            child: IconButton(onPressed: navigation,
             icon: Icon(Icons.arrow_forward)),
            )
      ],
    );
  }
}
