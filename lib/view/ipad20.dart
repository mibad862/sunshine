// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:provider/provider.dart';
// import 'package:sunshine_app/components/footer.dart';
// import 'package:sunshine_app/components/header.dart';
// import 'package:sunshine_app/components/visibility_wrapper.dart';
// import 'package:sunshine_app/view/ipad17.dart';
//
// import '../controller/ipad16_three_controller.dart';
//
// class Ipad20 extends StatefulWidget {
//   const Ipad20({super.key});
//
//   @override
//   State<Ipad20> createState() => _Ipad20State();
// }
//
// class _Ipad20State extends State<Ipad20> {
//   // List of stations (just for demonstration)
//   final List<String> stations = ["Station 1", "Station 2", "Station 3"];
//
//   // List to track the state of each station's container
//   List<String> containerStates = [];
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize container states as empty for each station
//     containerStates = List.filled(stations.length, "empty");
//   }
//
//   // Method to handle tap on a container
//   void _handleTap(int index) {
//     setState(() {
//       if (containerStates[index] == "empty") {
//         containerStates[index] = "Required";
//       } else if (containerStates[index] == "Required") {
//         containerStates[index] = "Requested";
//       } else if (containerStates[index] == "Requested") {
//         containerStates[index] = "Set Down";
//       } else {
//         containerStates[index] = "empty"; // Reset to empty if needed
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 20.0),
//           const Text(
//             "Stopping Pattern",
//             style: TextStyle(fontSize: 24.0),
//           ),
//           const SizedBox(height: 20.0),
//
//           // Displaying stations with containers in a Wrap
//           Row(
//             children: [
//
//               Container(
//                 width: 160,
//                 height: 60,
//                 decoration: BoxDecoration(
//                   color: Colors.red,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               Expanded(
//                 child: Wrap(
//                   spacing: 10.0,
//                   runSpacing: 10.0,
//                   children: List.generate(stations.length, (index) {
//                     return Column(
//                       children: [
//                         Text(
//                           stations[index],
//                           style: const TextStyle(
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () => _handleTap(index),
//                           child: Container(
//                             margin: const EdgeInsets.symmetric(vertical: 5.0),
//                             height: 60.0,
//                             width: 160.0, // Fixed width for uniformity
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade300,
//                               borderRadius: BorderRadius.circular(10.0),
//                               border: Border.all(color: Colors.black),
//                             ),
//                             alignment: Alignment.center,
//                             child: Text(
//                               containerStates[index] == "empty" ? "" : containerStates[index],
//                               style: const TextStyle(
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   }),
//                 ),
//               ),
//             ],
//           ),
//
//           // Buttons at the bottom
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.yellow,
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   width: 200.0,
//                   height: 60.0,
//                   alignment: Alignment.center,
//                   child: const Text("BACK"),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     // Handle save action here
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.yellow,
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     width: 200.0,
//                     height: 60.0,
//                     alignment: Alignment.center,
//                     child: const Text("SAVE"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 20.0),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';

class Ipad20 extends StatelessWidget {
  const Ipad20({super.key});

  @override
  Widget build(BuildContext context) {
    return VisibilityWrapper(
      bodyScreen: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30.0),
          Header(),
          const SizedBox(height: 20.0),
          const Text(
            'Stopping Pattern',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * .14,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.green.shade100,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Station Name',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "STARTING AT",
                      style: TextStyle(fontSize: 16.0),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * .85,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: List.generate(15, (index) {
                      return _buildStationCard(index + 1);
                    }),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.green.shade100,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'BACK',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Row(
                  children: [
                    Text(
                      "DEST",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.green.shade100,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'PARLIMENT',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.green.shade100,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .15,
          ),
          const Footer(isShowSettings: true),
        ],
      ),
    );
  }

  Widget _buildStationCard(int stationNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.blue.shade100,
            ),
            child: Text(
              'Station $stationNumber',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.green.shade100,
            ),
            child: Text(
              'Status $stationNumber',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
