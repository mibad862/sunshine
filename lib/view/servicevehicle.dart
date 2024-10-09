import 'package:flutter/material.dart';
import 'package:sunshine_app/colors/colors.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/view/report_damage.dart';

class ServiceVehicle extends StatelessWidget {
  const ServiceVehicle({super.key});

  @override
  Widget build(BuildContext context) {
     TextStyle currentTextStyle = const TextStyle(
      color: Color(0xff003B5C),
      fontSize: 20.0,
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
      MaterialPageRoute(builder: (context) => ReportDamage())
    );
  },
),
      Text("Service Vehicle",style: currentTextStyle.copyWith(fontSize: 36),),
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
                      Expanded(
                        flex: 1,
                        child: Text("5/8",style: currentTextStyle.copyWith(color: AppColors.primaryColor),)),
                      Expanded(flex:5,child: Text("Added Fuel?",style: currentTextStyle,)),
                      Expanded(flex:5,child:  Row(children: [
            GestureDetector(onTap: (){},
            child: Container(
      height: 40.0,
      width: 110.0,
      decoration: BoxDecoration(
      
         color: Colors.green,
         borderRadius: BorderRadius.circular(10.0)
      ),
      child: const Center(
        child:  Text("ADDED FUEL",style: TextStyle(color: Colors.white,fontSize: 16.0),),
      ),
            ),
            ),
            const SizedBox(width: 20.0,),
           const SizedBox(
            height: 40.0,
      width: 180.0,
           ),
      const SizedBox(width: 20.0,),
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
          ],)
       
                      )
                    ],
                  ),
                    SizedBox(height: 15.0,),
                   Row(
                     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                      Expanded(
                        flex: 1,
                        child: Text("3 Days",style: currentTextStyle.copyWith(color: AppColors.primaryColor),)),
                       Expanded(
                        flex: 5,
                        child: Text("Toilet Dumped?",style: currentTextStyle,)),
                        Expanded(
                          flex: 5,
                          child: OptionButtons())
                     ],
                   ),
                     SizedBox(height: 15.0,),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                      Expanded(flex:1,child: Text("23 Hr",style: currentTextStyle.copyWith(color: AppColors.primaryColor),)),
                       Expanded(flex:5,child: Text("Vaccumed?",style: currentTextStyle,)),
                        Expanded(flex:5,child: OptionButtons())
                     ],
                   ),
                     SizedBox(height: 15.0,),
                   Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                      Expanded(flex:1,child: Text("12 Hr",style: currentTextStyle.copyWith(color: AppColors.primaryColor),)),
                       Expanded(flex:5,child: Text("Washed?",style: currentTextStyle,)),
                        Expanded(flex:5,child: OptionButtons())
                     ],
                   ),
                     SizedBox(height: 15.0,),
                   Row(
                     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                      Expanded(
                        flex: 1,
                        child: Text("23 Hr",style: currentTextStyle.copyWith(color: AppColors.primaryColor),)),
                       Expanded(
                        flex: 5,
                        child: Text("Windscreen Scrubbed?",style: currentTextStyle,)),
                        Expanded(
                          flex: 5,
                          child: OptionButtons())
                     ],
                   ),
                     SizedBox(height: 15.0,),
                   Row(
                     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
      
                      Expanded(
                        flex: 1,
                        child: Text("4 Days",style: currentTextStyle.copyWith(color: AppColors.primaryColor),)),
                       Expanded(
                        flex: 5,
                        child: Text("Tyres Painted?",style: currentTextStyle,)),
                        Expanded(
                          flex: 5,
                          child: OptionButtons())
                     ],
                   ),
                     SizedBox(height: 15.0,),
                   Row(
                  //    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                      Expanded(
                        flex: 1,
                        child: Text("4 Days",style: currentTextStyle.copyWith(color: AppColors.primaryColor),)),
                       Expanded(
                        flex: 5,
                        child: Text("Rims Polised?",style: currentTextStyle,)),
                        Expanded(
                          flex: 5,
                          child: OptionButtons())
                     ],
                   ),
                   const SizedBox(height: 15.0,),
                   Row(
                   //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
      
                      Expanded(
                        flex: 1,
                        child: Text("6 Days",style: currentTextStyle.copyWith(color: AppColors.primaryColor),)),
                       Expanded(
                        flex: 5,
                        child: Text("A/c Filter Cleaned?",style: currentTextStyle,)),
                         Expanded(
                          flex: 5,
                          child:
                         Row(children: [
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
           SizedBox(
            height: 40.0,
      width: 180.0,
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
          ],)
       
                        
                        )
                     ],
                   ),
                   const SizedBox(height: 15.0,),
                   Row(
                   //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                      Expanded(
                        flex: 1,
                        child: Text("10 Days",style: currentTextStyle.copyWith(color: AppColors.primaryColor),)),
      
                       Expanded(
                        flex: 5,
                        child: Text("Washed Fluid Topped Up?",style: currentTextStyle,)),
                        const Expanded(
                          flex: 5,
                          child: OptionButtons())
                     ],
                   ),
                ],
              ),
              ),
              
      
            ],
          ),
          SizedBox(height: 15,),
      
          Row(
            children: [
              Expanded(child: SizedBox()),
              Expanded(child: Row(
              
                children: [
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
            //   SizedBox(width: 20.0,),
            SizedBox(width: 320.0,),
             GestureDetector(onTap: (){},
            child: Container(
      height: 40.0,
      width: 180.0,
      decoration: BoxDecoration(
      
         color: Color(0xfffec103),
         borderRadius: BorderRadius.circular(10.0)
      ),
      child: Center(
        child: Text("Confirm",style: TextStyle(color: Colors.white,fontSize: 16.0),),
      ),
            ),
            )
                ],
              ))
            ],
          ),
          SizedBox(height: 15.0,),
          Footer(isShowSettings: true)
        ],
      ),
    );
  }
}

class OptionButtons extends StatelessWidget {
  const OptionButtons({
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
        child: const Center(
          child: Text("Yes",style: TextStyle(color: Colors.white,fontSize: 16.0),),
        ),
      ),
      ),
      const SizedBox(width: 20.0,),
       GestureDetector(onTap: (){},
      child: Container(
        height: 40.0,
        width: 180.0,
        decoration: BoxDecoration(

           color: Colors.green,
           borderRadius: BorderRadius.circular(10.0)
        ),
       
        child: const Center(
          child: Text("Doesn\'t need it",style: TextStyle(color: Colors.white,fontSize: 16.0),),
        ),
      ),
      ),
        const SizedBox(width: 20.0,),
       GestureDetector(onTap: (){},
      child: Container(
        height: 40.0,
        width: 110.0,
        decoration: BoxDecoration(

           color: Colors.green,
           borderRadius: BorderRadius.circular(10.0)
        ),
        child: const Center(
          child: Text("No",style: TextStyle(color: Colors.white,fontSize: 16.0),),
        ),
      ),
      )
    ],);
  }
}