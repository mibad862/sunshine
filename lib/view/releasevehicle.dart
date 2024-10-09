import 'package:flutter/material.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/view/servicevehicle.dart';

class Releasevehicle extends StatelessWidget {
  const Releasevehicle({super.key});

  @override
  Widget build(BuildContext context) {
       TextStyle currentTextStyle = const TextStyle(
      color: Color(0xff003B5C),
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );
    return  Scaffold(
     
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           const SizedBox(height: 30.0,),
           Header(
  navigation: () {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => ServiceVehicle())
    );
  },
),
      Text("Release Vehicle",style: currentTextStyle.copyWith(fontSize: 36),),
      const SizedBox(height: 20.0,),
          Row(
            children: [
              SizedBox(width: MediaQuery.sizeOf(context).width*.90,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
               //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: Text("How much fuel is left?",style: currentTextStyle,)),
                      Expanded(child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
      
                               color: Colors.orange,
                               border: Border.all(
                                color: Colors.black
                               )
                            ),
                           
                            height: 40.0,width: 220.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                VerticalDivider(color: Colors.white,
                                thickness: 2,),
                                 VerticalDivider(color: Colors.white,
                                thickness: 2,),
      
                              ],
                            ),
                            ),
                          SizedBox(width: 20.0,),
             GestureDetector(onTap: (){},
            child: Container(
      height: 40.0,
      width: 110.0,
      decoration: BoxDecoration(
      
         color: Colors.green,
         borderRadius: BorderRadius.circular(10.0)
      ),
      child: const Center(
        child: Text("Full",style: TextStyle(color: Colors.white,fontSize: 16.0),),
      ),
            ),
            ),
      SizedBox(width: 20.0,),
             GestureDetector(onTap: (){},
            child: Container(
      height: 40.0,
      width: 110.0,
       decoration: BoxDecoration(
      
         color: Colors.green,
         borderRadius: BorderRadius.circular(10.0)
      ),
      child: Center(
        child: Text("Add Fuel",style: TextStyle(color: Colors.white,fontSize: 16.0),),
      ),
            ),
            )
      
                        ],
                      ))
                    ],
                  ),
                    SizedBox(height: 20.0,),
                   Row(
                     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       Expanded(child: Text("Did you dump the toilet??",style: currentTextStyle,)),
                        Expanded(child: OptionButtons())
                     ],
                   ),
                     SizedBox(height: 20.0,),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       Expanded(child: Text("Did you vaccum it?",style: currentTextStyle,)),
                        Expanded(child: OptionButtons())
                     ],
                   ),
                     SizedBox(height: 20.0,),
                   Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       Expanded(child: Text("Did you scrub the windscreen",style: currentTextStyle,)),
                        Expanded(child: OptionButtons())
                     ],
                   ),
                     SizedBox(height: 20.0,),
                   Row(
                     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       Expanded(child: Text("Did you paint the tyres?",style: currentTextStyle,)),
                        Expanded(child: OptionButtons())
                     ],
                   ),
                     SizedBox(height: 20.0,),
                   Row(
                     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       Expanded(child: Text("Did you polish the rims?",style: currentTextStyle,)),
                        Expanded(child: OptionButtons())
                     ],
                   ),
                     SizedBox(height: 20.0,),
                   Row(
                  //    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       Expanded(child: Text("Did you clean the A/C filter?",style: currentTextStyle,)),
                        Expanded(child: OptionButtons())
                     ],
                   ),
                   SizedBox(height: 20.0,),
                   Row(
                   //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       Expanded(child: Text("Did you top up the washer fluid?",style: currentTextStyle,)),
                        Expanded(child: OptionButtons())
                     ],
                   )
                ],
              ),
              ),
              
      
            ],
          ),
          SizedBox(height: 30,),
      
          Row(
            children: [
              Expanded(child: SizedBox()),
              Expanded(child: Row(
              
                children: [
                  SizedBox(width: 320,),
            //                 GestureDetector(onTap: (){},
            // child: Container(
            //   height: 40.0,
            //   width: 180.0,
            //    decoration: BoxDecoration(
      
            //      color: Color(0xfffec103),
            //      borderRadius: BorderRadius.circular(10.0)
            //   ),
            //   child: Center(
            //     child: Text("Back",style: TextStyle(color: Colors.white,fontSize: 16.0),),
            //   ),
            // ),
            // ),
      const SizedBox(width: 20.0,),
             GestureDetector(onTap: (){
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ServiceVehicle()),
      );
             },
            child: Container(
      height: 40.0,
      width: 180.0,
      decoration: BoxDecoration(
      
         color: const Color(0xfffec103),
         borderRadius: BorderRadius.circular(10.0)
      ),
      child: const Center(
        child: Text("Confirm",style: TextStyle(color: Colors.white,fontSize: 16.0),),
      ),
            ),
            )
                ],
              ))
            ],
          ),
          const SizedBox(height: 15.0,),
          const Footer(isShowSettings: true)
        ],
      ),
    );
  }
}

class OptionButtons extends StatelessWidget {
  Function? Func1;
  Function? Func2;
  Function? Func3;

   OptionButtons({
   
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      GestureDetector(onTap: (){},
      child: Container(
        height: 40.0,
        width: 110.0,
        decoration: BoxDecoration(

           color: Colors.green,
           borderRadius: BorderRadius.circular(10.0)
        ),
        child: Center(
          child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 16.0),),
        ),
      ),
      ),
      SizedBox(width: 20.0,),
       GestureDetector(onTap: (){},
      child: Container(
        height: 40.0,
        width: 220.0,
        decoration: BoxDecoration(

           color: Colors.green,
           borderRadius: BorderRadius.circular(10.0)
        ),
       
        child: Center(
          child: Text("Doesn\'t need it",style: TextStyle(color: Colors.white,fontSize: 16.0),),
        ),
      ),
      ),
        SizedBox(width: 20.0,),
       GestureDetector(onTap: (){},
      child: Container(
        height: 40.0,
        width: 110.0,
        decoration: BoxDecoration(

           color: Colors.green,
           borderRadius: BorderRadius.circular(10.0)
        ),
        child: Center(
          child: Text("No",style: TextStyle(color: Colors.white,fontSize: 16.0),),
        ),
      ),
      )
    ],);
  }
}