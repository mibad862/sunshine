import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
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
          const SizedBox(height: 20.0),
          Header(
            navigation: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Ipad17(startingStation: ''),
                  ));
            },
          ),
          const SizedBox(height: 20.0),
          const Text(
            "EMERGENCY CALL OUT",
            style: TextStyle(fontSize: 24.0),
          ),
          const SizedBox(height: 20.0),
          const Text(
            "Which Station?",
            style: TextStyle(
                color: Colors.green,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0),
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
                              color: value.selectedAlphabet == alphabets[index]
                                  ? Colors.green
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              alphabets[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 10.0),
              IconButton(
                icon: const Icon(Icons.forward, size: 60.0),
                onPressed: () {
                  animateListView();
                },
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: Consumer<Ipad16Controller>(
              builder: (context, controller, child) {
                if (controller.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.errorMessage.isNotEmpty) {
                  return Center(child: Text(controller.errorMessage));
                } else if (controller.filteredStations.isEmpty) {
                  return const Center(child: Text("No stations found"));
                } else {
                  return SingleChildScrollView(
                    child: Wrap(
                      children: controller.filteredStations.map((station) {
                        return InkWell(
                          onTap: () {
                            controller.changeSelectedStation(station);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 10.0),
                            height: 55.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                              color: controller.selectedStation == station
                                  ? Colors.red
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              station.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * .020),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10.0)),
                    width: 200.0,
                    height: 60.0,
                    alignment: Alignment.center,
                    child: const Text("BACK"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final selectedStation =
                        Provider.of<Ipad16Controller>(context, listen: false)
                            .selectedStation;

                    if (selectedStation != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Ipad17(
                            startingStation: selectedStation.name,
                            lineID: selectedStation.lineId,
                            stationID: selectedStation.id,
                          ),
                        ),
                      );
                    } else {
                      Fluttertoast.showToast(msg: "Please Select a Station First");
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10.0)),
                    width: 200.0,
                    height: 60.0,
                    alignment: Alignment.center,
                    child: const Text("NEXT"),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .020),
          const Footer(isShowSettings: true),
        ],
      ),
    );
  }
}

