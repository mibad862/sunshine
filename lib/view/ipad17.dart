import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/view/ipad16-three.dart';
import 'package:sunshine_app/view/ipad19.dart';
import 'package:sunshine_app/view/ipad20.dart';

import '../controller/ipad17_controller.dart';

class Ipad17 extends StatefulWidget {
  final String? startingStation;
  final String? stationID;
  final String? lineID;

  const Ipad17({
    super.key,
    this.startingStation,
    this.stationID,
    this.lineID,
  });

  @override
  State<Ipad17> createState() => _Ipad17State();
}

class _Ipad17State extends State<Ipad17> {
  String destinationStaionName = "";
  String destinationStaionId = "";

  List<Map<String, dynamic>> stoppingPattern = [];

  int paxCounter = 0;

  void incrementPaxCount() {
    setState(() {
      paxCounter++; // Increment the count
    });
  }

  // Method to decrement pax count
  void decrementPaxCount() {
    setState(() {
      if (paxCounter > 0) {
        paxCounter--; // Decrement the count, ensuring it doesn't go below 0
      } else {
        Fluttertoast.showToast(msg: "Pax Count Cannot be less than 0");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Use the controller to fetch and manage direction status
    return ChangeNotifierProvider(
      create: (_) =>
          Ipad17Controller()..fetchDirectionStatus(widget.stationID!),
      child: Consumer<Ipad17Controller>(
        builder: (context, controller, child) {
          return VisibilityWrapper(
            bodyScreen: Scaffold(
              backgroundColor: Colors.grey,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  Header(
                    navigation: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Ipad19()));
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 90.0,
                      ),
                      Text(
                        "EMERGENCY CALL OUT",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height * .25,
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .66,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Starting at",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    height: 60.0,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    alignment: Alignment.center,
                                    child: Text(widget.startingStation ?? ""),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller
                                          .onArriveNowPressed(); // Call the method from the controller
                                      print(
                                          "Arrive Now pressed at: ${controller.arrivedTime}"); // Debug print
                                    },
                                    child: Container(
                                      height: 60.0,
                                      width: 150.0,
                                      decoration: BoxDecoration(
                                        color: controller.arriveNowButtonColor,
                                        // Use color from controller
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text("ARRIVE NOW"),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Supervisor",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    width: 150,
                                    height: 55,
                                    child: TextFormField(
                                      controller:
                                          controller.supervisorController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 60.0,
                                    width: 150.0,
                                    alignment: Alignment.center,
                                    //  child: Text("ARRIVE NOW"),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Direction",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),

                                  GestureDetector(
                                    onTap: controller.canGoUpValue
                                        ? controller
                                            .toggleUpButton // Toggle only if accessible
                                        : null,
                                    child: Container(
                                      height: 60,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: controller.canGoUpValue
                                            ? controller.upButtonColor
                                            : Colors.black26,
                                        // Dynamic color
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text("UP"), // Text based on value
                                    ),
                                  ),
                                  // GestureDetector(
                                  //   onTap: controller.canGoUpAccessible
                                  //       ? () {
                                  //           controller.toggleCanGoUp();
                                  //           print("UP");
                                  //         }
                                  //       : () {
                                  //           print("UP button disabled");
                                  //         },
                                  //   child: Container(
                                  //     height: 60.0,
                                  //     width: 150.0,
                                  //     decoration: BoxDecoration(
                                  //       color: controller.canGoUpValue
                                  //           ? Colors.yellow
                                  //           : Colors.black45,
                                  //       borderRadius:
                                  //           BorderRadius.circular(10.0),
                                  //     ),
                                  //     alignment: Alignment.center,
                                  //     child: const Text("UP"),
                                  //   ),
                                  // ),
                                  GestureDetector(
                                    onTap: controller.canGoDownValue
                                        ? controller
                                            .toggleDownButton // Toggle only if accessible
                                        : null,
                                    child: Container(
                                      height: 60.0,
                                      width: 150.0,
                                      decoration: BoxDecoration(
                                        color: controller.canGoDownValue
                                            ? controller.downButtonColor
                                            : Colors.black26,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text("DOWN"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Pax Count",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(width: 10),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: incrementPaxCount,
                                  child: Container(
                                    height: 35,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10)),
                                    ),
                                    child: Icon(
                                      Icons.plus_one,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.center,
                                  height: 35,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                  ),
                                  child: Text(paxCounter.toString()),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: decrementPaxCount,
                                  child: Container(
                                    height: 35,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                    ),
                                    child: Icon(
                                      Icons.exposure_minus_1,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 250.0, // Adjust as per your widget height
                        //   width: MediaQuery.sizeOf(context).width * .33,
                        //   child: GestureDetector(
                        //     onTapUp: (details) {
                        //       final localPosition = details.localPosition.dy;
                        //       final totalHeight =
                        //           250.0; // Full height of the widget
                        //       final triangleHeight = totalHeight / 4;
                        //       final containerHeight = totalHeight / 4;
                        //       final spacing = 10.0;
                        //       final topTriangleArea = triangleHeight;
                        //       final bottomTriangleArea = triangleHeight +
                        //           containerHeight +
                        //           2 * spacing;
                        //
                        //       // Check if the tap is in the upper triangle
                        //       if (localPosition < topTriangleArea) {
                        //         setState(() {
                        //           paxCounter++; // Increment when the upper triangle is tapped
                        //         });
                        //       }
                        //       // Check if the tap is in the lower triangle
                        //       else if (localPosition > bottomTriangleArea) {
                        //         setState(() {
                        //           paxCounter--; // Decrement when the lower triangle is tapped
                        //         });
                        //       }
                        //     },
                        //     child: CustomPaint(
                        //       painter: OdometerSmallPainter(
                        //           paxCounter:
                        //               paxCounter), // Pass paxCounter to the painter
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height * .23,
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .66,
                          child: Column(
                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Destination station",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),

                                  GestureDetector(
                                    onTap: () async {
                                      // Check if both UP and DOWN are selected
                                      if (controller.upButtonValue != null &&
                                          controller.downButtonValue != null) {
                                        // Show a message if both are selected (though only one should be selected at a time)
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Please select only one direction.'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                      // Check if neither direction is selected
                                      else if (controller.upButtonValue ==
                                              null &&
                                          controller.downButtonValue == null) {
                                        // Show a message if neither is selected
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Please select a direction.'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                      // If only one direction is selected, navigate to the next screen
                                      else {
                                        String direction =
                                            controller.upButtonValue == "UP"
                                                ? "Up"
                                                : "Down";
                                        print("Direction: $direction");

                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Ipad16Three(
                                              direction: direction,
                                              startingStationID:
                                                  widget.stationID ?? "",
                                            ),
                                          ),
                                        );

                                        // Process the result received from Ipad16Three
                                        if (result != null) {
                                          setState(() {
                                            destinationStaionName = result[0];
                                            controller.destinationName =
                                                result[0];
                                            destinationStaionId = result[1];
                                            controller.destinationId =
                                                result[1];
                                          });

                                          // Display result in a snackbar
                                          ScaffoldMessenger.of(context)
                                            ..removeCurrentSnackBar()
                                            ..showSnackBar(SnackBar(
                                                content: Text(
                                                    "Destination: $destinationStaionName (ID: $destinationStaionId)")));
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 60.0,
                                      width: 150.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        destinationStaionName.isNotEmpty
                                            ? destinationStaionName
                                            : "Choose",
                                      ),
                                    ),
                                  ),

                                  // GestureDetector(
                                  //   onTap: () async {
                                  //     // Check if both UP and DOWN are selected
                                  //     if (controller.canGoUpValue &&
                                  //         controller.canGoDownValue) {
                                  //       // Show a message if both are true
                                  //       ScaffoldMessenger.of(context)
                                  //           .showSnackBar(
                                  //         const SnackBar(
                                  //           content: Text(
                                  //               'Please select only one direction.'),
                                  //           duration: Duration(seconds: 2),
                                  //         ),
                                  //       );
                                  //     } else if (controller.canGoUpValue ||
                                  //         controller.canGoDownValue) {
                                  //       // If only one is true, navigate to the next screen
                                  //       String direction =
                                  //           controller.canGoUpValue
                                  //               ? "Up"
                                  //               : "Down";
                                  //       print("Direction : $direction");
                                  //
                                  //       final result = await Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //           builder: (context) => Ipad16Three(
                                  //             direction: direction,
                                  //             startingStationID:
                                  //                 widget.stationID ?? "",
                                  //           ),
                                  //         ),
                                  //       );
                                  //
                                  //       // Process the result received from Ipad16Three
                                  //       if (result != null) {
                                  //         // Do something with the returned value
                                  //         setState(() {
                                  //           destinationStaionName = result[0];
                                  //           controller.destinationName =
                                  //               result[0];
                                  //           destinationStaionId = result[1];
                                  //           controller.destinationId =
                                  //               result[1];
                                  //         });
                                  //         print(
                                  //             "Dest Name $destinationStaionName");
                                  //         print("Dest Id $destinationStaionId");
                                  //         ScaffoldMessenger.of(context)
                                  //           ..removeCurrentSnackBar()
                                  //           ..showSnackBar(SnackBar(
                                  //               content: Text("$result")));
                                  //       }
                                  //     } else {
                                  //       ScaffoldMessenger.of(context)
                                  //           .showSnackBar(
                                  //         const SnackBar(
                                  //           content: Text(
                                  //               'Please select a direction.'),
                                  //           duration: Duration(seconds: 2),
                                  //         ),
                                  //       );
                                  //     }
                                  //   },
                                  //   child: Container(
                                  //     height: 60.0,
                                  //     width: 150.0,
                                  //     decoration: BoxDecoration(
                                  //         color: Colors.white,
                                  //         borderRadius:
                                  //             BorderRadius.circular(10.0)),
                                  //     alignment: Alignment.center,
                                  //     child: Text(
                                  //       destinationStaionName.isNotEmpty
                                  //           ? destinationStaionName
                                  //           : "Choose",
                                  //     ),
                                  //   ),
                                  // ),
                                  Container(
                                    height: 60.0,
                                    width: 150.0,

                                    alignment: Alignment.center,
                                    //  child: Text("ARRIVE NOW"),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Stopping Pattern",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      // Check if destinationStationName and destinationStationId are not null
                                      if (controller.destinationName == null ||
                                          controller.destinationId == null) {
                                        // Display a SnackBar or error message if destination details are missing
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Please select a valid destination station.')),
                                        );
                                      } else {
                                        // Navigate to Ipad20 and wait for the result if destination details are valid
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Ipad20(
                                              startingAtStation:
                                                  widget.startingStation ?? "",
                                              startingAtStationId:
                                                  widget.stationID ?? "",
                                              destinationStation:
                                                  destinationStaionName,
                                              destinationStationId:
                                                  destinationStaionId,
                                            ),
                                          ),
                                        );

                                        // Check if we received any data back
                                        if (result != null &&
                                            result
                                                is List<Map<String, dynamic>>) {
                                          setState(() {
                                            stoppingPattern =
                                                result; // Update the local state with the returned stations
                                            print("Stopping Pattern");
                                            print(stoppingPattern);
                                          });
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 60.0,
                                      width: 150.0,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        stoppingPattern.isEmpty
                                            ? 'Choose' // At the start or when no stations are selected
                                            : stoppingPattern.length == 0
                                                ? '0 Stations' // When stoppingPattern length becomes 0
                                                : '${stoppingPattern.length} Stations',
                                        // When stations are selected
                                        // Show 'Choose' when array is empty
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 60.0,
                                    width: 150.0,
                                    //  decoration: BoxDecoration(
                                    //      //  color: Colors.yellow,
                                    //       // borderRadius: BorderRadius.circular(10.0)
                                    //  ),
                                    alignment: Alignment.center,
                                    //  child: Text("ARRIVE NOW"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .33,
                          child: Row(
                            children: [
                              Consumer<Ipad17Controller>(
                                builder: (context, controller, child) {
                                  return controller.isLoading
                                      ? const CircularProgressIndicator() // Display loading spinner when loading
                                      : InkWell(
                                          onTap: () {
                                            controller.departNow(
                                              widget.stationID ?? "",
                                              controller.upButtonValue == "UP"
                                                  ? "Up"
                                                  : "Down",
                                              destinationStaionId,
                                              widget.lineID ?? "",
                                              paxCounter.toString(),
                                              stoppingPattern,
                                              context
                                            );
                                          },
                                          child: Container(
                                            height: 130.0,
                                            width: 350.0,
                                            decoration: BoxDecoration(
                                                color: Colors.yellow,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "DEPART DOWN",
                                              style: TextStyle(fontSize: 20.0),
                                            ),
                                          ),
                                        );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .66,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 60.0,
                                width: 150.0,
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(10.0)),
                                alignment: Alignment.center,
                                child: const Text("BACK"),
                              ),
                            ),
                            Container(
                              height: 100.0,
                              width: 250.0,
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(10.0)),
                              alignment: Alignment.center,
                              child: Text("STAND BY"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .33,
                        child: Row(
                          children: [
                            Container(
                              height: 130.0,
                              width: 350.0,
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(10.0)),
                              alignment: Alignment.center,
                              child: Text(
                                "SHOW MAPS",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  const Footer(isShowSettings: true)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class OdometerSmallPainter extends CustomPainter {
  final int paxCounter;

  OdometerSmallPainter({required this.paxCounter});

  @override
  void paint(Canvas canvas, Size size) {
    // Paint object for blue triangles
    final trianglePaint = Paint()
      ..color = Colors.blue.withOpacity(0.7) // Blue for triangles
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    // Paint object for red boxes
    final boxPaint = Paint()
      ..color = Colors.red // Red for boxes
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final triangleHeight = size.height / 4;
    final triangleWidth = size.width / 7;
    final containerHeight = size.height / 4;
    final spacing = 10.0; // Spacing between triangles and boxes

    // Adjusted triangle width for spacing
    final adjustedWidth = (size.width - (2 * spacing)) / 7;

    // Drawing top triangles (with spacing)
    for (int i = 0; i < 1; i++) {
      final path = Path();
      final startX = i * (adjustedWidth + spacing);
      path.moveTo(startX + adjustedWidth / 2, 0); // Top center
      path.lineTo(startX, triangleHeight); // Bottom left
      path.lineTo(startX + adjustedWidth, triangleHeight); // Bottom right
      path.close();
      canvas.drawPath(path, trianglePaint); // Draw the upper triangle
    }

    // Drawing containers (with spacing)
    for (int i = 0; i < 1; i++) {
      final startX = i * (adjustedWidth + spacing);
      final rect = Rect.fromLTWH(
        startX,
        triangleHeight + spacing, // Spacing below the top triangles
        adjustedWidth,
        containerHeight,
      );
      canvas.drawRect(rect, boxPaint); // Draw the container
    }

    // Drawing bottom triangles (with spacing)
    for (int i = 0; i < 1; i++) {
      final path = Path();
      final startX = i * (adjustedWidth + spacing);
      final bottomYStart = triangleHeight + spacing + containerHeight + spacing;

      path.moveTo(startX + adjustedWidth / 2,
          bottomYStart + triangleHeight); // Bottom center of the triangle
      path.lineTo(startX, bottomYStart); // Top left of the triangle
      path.lineTo(
          startX + adjustedWidth, bottomYStart); // Top right of the triangle
      path.close();
      canvas.drawPath(path, trianglePaint); // Draw the lower triangle
    }

    // Draw the current paxCounter value in the center square
    final textPainter = TextPainter(
      text: TextSpan(
        text: paxCounter.toString(),
        style: TextStyle(
            color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    final startX = (size.width - textPainter.width) / 2;
    final startY =
        (triangleHeight + spacing + containerHeight - textPainter.height) / 2 +
            triangleHeight +
            spacing;

    textPainter.paint(
        canvas, Offset(startX, startY)); // Draw paxCounter in the box
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Allow repainting when paxCounter changes
  }
}
