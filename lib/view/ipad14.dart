import 'package:flutter/material.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/view/ipad15.dart';

class Ipad14 extends StatelessWidget {
  const Ipad14({super.key});

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
      MaterialPageRoute(builder: (context) => Ipad15())
    );
  },
),

        const SizedBox(height: 18.0,),
        const Text("Emergency Call Out",style: TextStyle(fontSize: 32.0,fontWeight: FontWeight.bold),),
        const SizedBox(height: 17.0,),
        const Row(
          children: [
            SizedBox(width: 80.0,),
            Text("Which V/Line  line?",style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,color: Colors.green),),
          ],
        ),
        const SizedBox(height: 17.0,),
        // Text("Break Due In <Next Break>",style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
       // SizedBox(height: MediaQuery.sizeOf(context).height*.2,),
           Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MoreButtons(buttonText: "Albury", func: (){})
            , 
            const SizedBox(width: 20.0,),
            MoreButtons(buttonText: "Geelong", func: (){}),
            //  MoreButtons(buttonText: "Mernda", func: (){}),
            //   MoreButtons(buttonText: "Sunbury", func: (){}),
              //  MoreButtons(buttonText: "SHOW MAPS", func: (){})
      
          ],
        ),
        const SizedBox(height: 17.0,),
            Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MoreButtons(buttonText: "Ararat", func: (){})
            , 
             const SizedBox(width: 20.0,),
            MoreButtons(buttonText: "Seymour", func: (){}),
            //  MoreButtons(buttonText: "Pakenham", func: (){}),
            //   MoreButtons(buttonText: "Upfield", func: (){}),
              //  MoreButtons(buttonText: "SHOW MAPS", func: (){})
      
          ],
        ),
        const SizedBox(height: 17.0,),
            Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MoreButtons(buttonText: "Ballarat", func: (){})
            , 
             const SizedBox(width: 20.0,),
            MoreButtons(buttonText: "Shepparton", func: (){}),
            //  MoreButtons(buttonText: "Sandringham", func: (){}),
            //   MoreButtons(buttonText: "Werribee", func: (){}),
              //  MoreButtons(buttonText: "SHOW MAPS", func: (){})
      
          ],
        ),
        const SizedBox(height: 17.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MoreButtons(buttonText: "Bendigo", func: (){})
            , 
             SizedBox(width: 20.0,),
            MoreButtons(buttonText: "Traralgon", func: (){}),
             SizedBox(width: 20.0,),
             MoreButtons(buttonText: "Warrnambool", func: (){}),
              // MoreButtons(buttonText: "Williamstown", func: (){}),
              //  MoreButtons(buttonText: "SHOW MAPS", func: (){})
      
          ],
        ),
        const SizedBox(height: 17.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MoreButtons(buttonText: "Next", func: (){})
          ],
        ),
        const SizedBox(height: 18,),
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
          child: Text(buttonText,style: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}
