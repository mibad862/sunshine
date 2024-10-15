import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/view/ipad17.dart';

import '../controller/ipad16_three_controller.dart';

class Ipad16Three extends StatefulWidget {
  final String direction; // Add this to accept lineID
  final String startingStationID; // Add this to accept lineID

  const Ipad16Three({
    super.key,
    required this.direction,
    required this.startingStationID,
  });

  @override
  State<Ipad16Three> createState() => _Ipad16ThreeState();
}

class _Ipad16ThreeState extends State<Ipad16Three> {
  @override
  Widget build(BuildContext context) {
    final logger = Logger();

    return ChangeNotifierProvider(
      create: (context) => Ipad16ThreeController(
        startingStationId: widget.startingStationID,
        direction: widget.direction,
      ),
      // Initialize controller with lineID
      child: Consumer<Ipad16ThreeController>(
        builder: (context, controller, child) {
          return VisibilityWrapper(
            bodyScreen: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                Header(
                  navigation: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Ipad17()));
                  },
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "EMERGENCY CALL OUT 16 Three",
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
                  child: controller.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : controller.errorMessage.isNotEmpty
                          ? Center(child: Text(controller.errorMessage))
                          : controller.stations.isEmpty
                              ? const Center(child: Text("No stations found"))
                              : Wrap(
                                  children: controller.stations.map((station) {
                                    return GestureDetector(
                                      onTap: () {
                                        controller.selectStationName(
                                          station.name ?? "",
                                        );
                                        controller.selectStationId(
                                          station.stationId ?? 1,
                                        );
                                        logger.d(
                                            "Tapped station: ${station.name}, ID: ${station.stationId}");
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 10.0),
                                        height: 55.0,
                                        width: 160.0,
                                        decoration: BoxDecoration(
                                          color: controller
                                                          .selectedStationName ==
                                                      station.name &&
                                                  controller
                                                          .selectedStationId ==
                                                      station.stationId
                                              ? Colors.blue
                                              : Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Text(
                                          station.name ?? "",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17.0,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                ),

                SizedBox(height: MediaQuery.sizeOf(context).height * .020),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
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
                        onTap: () async {
                          var controller = Provider.of<Ipad16ThreeController>(
                              context,
                              listen: false);

                          logger.d(
                              "Tapped station: ${controller.selectedStationName}");
                          // logger.d("Selected station: ${controller.selectedStation?.name}");
                          if (controller.selectedStationName != null) {
                            // Navigate back and pass the selected station's name
                            // Navigator.pop(context, controller.selectedStation);

                            await Future<void>.delayed(
                                const Duration(seconds: 1));
                            if (mounted) {
                              setState(() {
                                // Navigator.pop(context);

                                logger.d(
                                    "Passing station ID: ${controller.startingStationId}");

                                Navigator.pop(context, [
                                  controller.selectedStationName,
                                  // "8"
                                  controller.selectedStationId.toString(),
                                ]);
                              });
                            } else {
                              print("Widget is not mounted");
                            }

                            print(controller.selectedStationName);
                          } else {
                            // Show a toast message if no station is selected
                            if (mounted) {
                              toast("Please select a station");
                            }
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
        },
      ),
    );
  }
}
