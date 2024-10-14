import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/controller/ipad16_controller.dart';
import 'package:sunshine_app/view/ipad17.dart';

import '../controller/ipad16_two_controller.dart';

class Ipad16Two extends StatelessWidget {
  final String lineID; // Add this to accept lineID

  const Ipad16Two({super.key, required this.lineID});

  @override
  Widget build(BuildContext context) {

    final Logger logger;
    return ChangeNotifierProvider(
      create: (context) => Ipad16TwoController(lineID: lineID),
      // Initialize controller with lineID
      child: VisibilityWrapper(
        bodyScreen: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Header(
              navigation: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Ipad17()));
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

            const SizedBox(height: 20.0),
            // Fetch and display filtered stations
            Expanded(
              child: Consumer<Ipad16TwoController>(
                builder: (context, controller, child) {
                  if (controller.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.errorMessage.isNotEmpty) {
                    return Center(child: Text(controller.errorMessage));
                  } else if (controller.stations.isEmpty) {
                    return const Center(child: Text("No stations found"));
                  } else {
                    return Wrap(
                      children: controller.stations.map((station) {
                        return InkWell(
                          onTap: (){
                            controller.changeSelectedStation(station);
                            print("Station tapped: ${station.name}"); // Debug log
                            print("Current selected station: ${controller.selectedStation?.name}"); // Debug log
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 10.0),
                            height: 48.0,
                            width: 140.0,
                            decoration: BoxDecoration(
                              color: controller.selectedStation == station
                                  ? Colors.blue
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              station.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
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
                  GestureDetector(
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

                  Consumer<Ipad16TwoController>(
                    builder: (context, controller, child) {
                      return GestureDetector(
                        onTap: () {
                          final selectedStation = controller.selectedStation;

                          print("Selected Station before navigation: ${selectedStation?.name}"); // Debug log

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
                      );
                    },
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     final selectedStation =
                  //         Provider.of<Ipad16TwoController>(context, listen: false)
                  //             .selectedStation;
                  //
                  //     print("Selected Station before navigation: ${selectedStation?.name}"); // Debug log
                  //
                  //     if (selectedStation != null) {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => Ipad17(
                  //             startingStation: selectedStation.name,
                  //             lineID: selectedStation.lineId,
                  //             stationID: selectedStation.id,
                  //           ),
                  //         ),
                  //       );
                  //     } else {
                  //       Fluttertoast.showToast(msg: "Please Select a Station First");
                  //     }
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         color: Colors.yellow,
                  //         borderRadius: BorderRadius.circular(10.0)),
                  //     width: 200.0,
                  //     height: 60.0,
                  //     alignment: Alignment.center,
                  //     child: const Text("NEXT"),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .020),
            const Footer(isShowSettings: true),
          ],
        ),
      ),
    );
  }
}



