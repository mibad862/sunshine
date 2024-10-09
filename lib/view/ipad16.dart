import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/controller/ipad16_controller.dart';
import 'package:sunshine_app/view/ipad17.dart';

class Ipad16 extends StatelessWidget {
  const Ipad16({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> alphabets = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];
    List<String> locations = [
      'Alamein',
      'Altona',
      'Ascot Vale',
      'Auburn',
      'Albion',
      'Anstey',
      'Ashburton',
      'Alamein',
      'Altona',
      'Ascot Vale',
      'Auburn',
      'Albion',
      'Anstey',
      'Ashburton',
    ];
    final ScrollController scrollController = ScrollController();
    void animateListView() {
      final position = scrollController.position.maxScrollExtent;
      scrollController.animateTo(position,
          duration: const Duration(seconds: 1), curve: Curves.easeIn);
    }

    return VisibilityWrapper(
      bodyScreen: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20.0,
          ),
         Header(
  navigation: () {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => Ipad17())
    );
  },
),

            const SizedBox(
            height: 20.0,
          ),
          const Text("EMERGENCY CALL OUT",style: TextStyle(fontSize: 24.0),),
               const SizedBox(
            height: 20.0,
          ),
          const Text("Which Station?",style: TextStyle(color: Colors.green,fontSize: 20.0,fontWeight: FontWeight.bold),),
               const SizedBox(
            height: 20.0,
          ),

          Row(
            children: [
              SizedBox(
                height: 60.0,
                width: MediaQuery.sizeOf(context).width * .85,
                child: ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: alphabets.length,
                  itemBuilder: (context, index) {
                    return Consumer<Ipad16Controller>(
                      builder: (BuildContext context, value, Widget? child) {
                        return GestureDetector(
                          onTap: () {
                            value.changeColor(selectedValue: alphabets[index]);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            height: 30.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                              color: value.selectedAlphabet==alphabets[index]
                                  ? Colors.green
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              alphabets[index],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              IconButton(
                icon: const Icon(Icons.forward, size: 60.0),
                onPressed: () {
                  animateListView();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Wrap(
            children: locations.map((location) {
              return Container(
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                height: 60.0,
                width: 120.0,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  location,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height*.1,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 24.0),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  
                 decoration: BoxDecoration(
                   color: Colors.yellow,
                   borderRadius: BorderRadius.circular(10.0)
                 ),
                width: 200.0,
                height: 60.0,
                alignment: Alignment.center,
                child: Text("BACK"),
                ),
                Container(
                  decoration: BoxDecoration(
                   color: Colors.yellow,
                   borderRadius: BorderRadius.circular(10.0)
                 ),
                 width: 200.0,
                height: 80.0,
                  alignment: Alignment.center,
                child: Text("NEXT"),
                )
             
             
              ],
                       ),
           ),
            SizedBox(height: MediaQuery.sizeOf(context).height*.17,),
          const Footer(isShowSettings: true)
        ],
      ),
    );
  }
}
