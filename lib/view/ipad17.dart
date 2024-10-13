import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/view/ipad16-three.dart';
import 'package:sunshine_app/view/ipad19.dart';
import 'package:sunshine_app/view/ipad20.dart';
import 'package:sunshine_app/view/ipad21.dart';
import '../controller/ipad17_controller.dart';

class Ipad17 extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // Use the controller to fetch and manage direction status
    return ChangeNotifierProvider(
      create: (_) => Ipad17Controller()..fetchDirectionStatus(stationID!),
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
                                    child: Text(startingStation ?? ""),
                                  ),
                                  Container(
                                    height: 60.0,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    alignment: Alignment.center,
                                    child: Text("ARRIVE NOW"),
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
                                    height: 60.0,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    alignment: Alignment.center,
                                    child: const Text(""),
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
                                    onTap: controller.canGoUpAccessible
                                        ? () {
                                            controller.toggleCanGoUp();
                                            print("UP");
                                          }
                                        : () {
                                            print("UP button disabled");
                                          },
                                    child: Container(
                                      height: 60.0,
                                      width: 150.0,
                                      decoration: BoxDecoration(
                                        color: controller.canGoUpValue
                                            ? Colors.yellow
                                            : Colors.black45,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text("UP"),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: controller.canGoDownAccessible
                                        ? () {
                                            controller.toggleCanGoDown();
                                            print("DOWN");
                                          }
                                        : () {
                                            print("UP button disabled");
                                            print(controller.canGoUpAccessible);
                                            print(controller.canGoUpValue);
                                          },
                                    child: Container(
                                      height: 60.0,
                                      width: 150.0,
                                      decoration: BoxDecoration(
                                        color: controller.canGoDownValue
                                            ? Colors.green
                                            : Colors.black45,
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
                        SizedBox(
                          height: 250.0,
                          width: MediaQuery.sizeOf(context).width * .33,
                          child: CustomPaint(
                            painter: OdometerSmallPainter(),
                          ),
                        )
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

                                  // GestureDetector(
                                  //   onTap: () async {
                                  //     if (controller.canGoUpValue && controller.canGoDownValue) {
                                  //       ScaffoldMessenger.of(context).showSnackBar(
                                  //         const SnackBar(
                                  //           content: Text('Please select only one direction.'),
                                  //           duration: Duration(seconds: 2),
                                  //         ),
                                  //       );
                                  //     } else if (controller.canGoUpValue || controller.canGoDownValue) {
                                  //       String direction = controller.canGoUpValue ? "Up" : "Down";
                                  //       print("Direction : $direction");
                                  //
                                  //       // Use mounted to check if the widget is still in the widget tree
                                  //       if (context.mounted) {
                                  //         final result = await Navigator.push(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //             builder: (context) => Ipad16Three(
                                  //               direction: direction,
                                  //               startingStationID: stationID ?? "",
                                  //             ),
                                  //           ),
                                  //         );
                                  //
                                  //         if (result != null) {
                                  //           print("Returned value: $result");
                                  //         }
                                  //       }
                                  //     } else {
                                  //       ScaffoldMessenger.of(context).showSnackBar(
                                  //         const SnackBar(
                                  //           content: Text('Please select a direction.'),
                                  //           duration: Duration(seconds: 2),
                                  //         ),
                                  //       );
                                  //     }
                                  //   },
                                  //   child: Container(
                                  //     height: 60.0,
                                  //     width: 150.0,
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.white,
                                  //       borderRadius: BorderRadius.circular(10.0),
                                  //     ),
                                  //     alignment: Alignment.center,
                                  //     child: const Text("Choose"),
                                  //   ),
                                  // ),
                                  GestureDetector(
                                    onTap: () async {
                                      // Check if both UP and DOWN are selected
                                      if (controller.canGoUpValue &&
                                          controller.canGoDownValue) {
                                        // Show a message if both are true
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Please select only one direction.'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      } else if (controller.canGoUpValue ||
                                          controller.canGoDownValue) {
                                        // If only one is true, navigate to the next screen
                                        String direction =
                                            controller.canGoUpValue
                                                ? "Up"
                                                : "Down";
                                        print("Direction : $direction");

                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Ipad16Three(
                                              direction: direction,
                                              startingStationID:
                                                  stationID ?? "",
                                            ),
                                          ),
                                        );

                                        // Process the result received from Ipad16Three
                                        if (result != null) {
                                          // Do something with the returned value
                                          ScaffoldMessenger.of(context)
                                            ..removeCurrentSnackBar()
                                            ..showSnackBar(SnackBar(
                                                content: Text("$result")));
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Please select a direction.'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                      //   Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) => Ipad16Three(
                                      //         direction: direction,
                                      //         startingStationID: stationID ?? "",
                                      //       ),
                                      //     ),
                                      //   );
                                      // } else {
                                      //   // If none are selected, show a warning
                                      //   ScaffoldMessenger.of(context).showSnackBar(
                                      //     const SnackBar(
                                      //       content: Text('Please select a direction.'),
                                      //       duration: Duration(seconds: 2),
                                      //     ),
                                      //   );
                                      // }
                                    },
                                    child: Container(
                                      height: 60.0,
                                      width: 150.0,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      alignment: Alignment.center,
                                      child: const Text("Choose"),
                                    ),
                                  ),

                                  // GestureDetector(
                                  //   onTap: () {
                                  //     Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) => Ipad16Three(
                                  //                   direction: "UP",
                                  //                   startingStationID:
                                  //                       stationID ?? "",
                                  //                 )));
                                  //   },
                                  //   child: Container(
                                  //     height: 60.0,
                                  //     width: 150.0,
                                  //     decoration: BoxDecoration(
                                  //         color: Colors.white,
                                  //         borderRadius:
                                  //             BorderRadius.circular(10.0)),
                                  //     alignment: Alignment.center,
                                  //     child: const Text("Choose"),
                                  //   ),
                                  // ),
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
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Ipad20()));
                                    },
                                    child: Container(
                                      height: 60.0,
                                      width: 150.0,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      alignment: Alignment.center,
                                      child: const Text("Choose"),
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
                              Container(
                                height: 130.0,
                                width: 350.0,
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(10.0)),
                                alignment: Alignment.center,
                                child: Text(
                                  "DEPART DOWN",
                                  style: TextStyle(fontSize: 20.0),
                                ),
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
                            Container(
                              height: 60.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(10.0)),
                              alignment: Alignment.center,
                              child: const Text("BACK"),
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
  @override
  void paint(Canvas canvas, Size size) {
    // Paint object for red triangles
    final trianglePaint = Paint()
      ..color = Colors.blue.withOpacity(0.7) // Red for triangles
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    // Paint object for yellow boxes
    final boxPaint = Paint()
      ..color = Colors.red // Yellow for boxes
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
      canvas.drawPath(
          path, trianglePaint); // Use trianglePaint for red triangles
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
      canvas.drawRect(rect, boxPaint); // Use boxPaint for yellow boxes
    }

    // Drawing bottom triangles (with spacing)
    // Adding similar spacing below the containers like the top triangles
    for (int i = 0; i < 1; i++) {
      final path = Path();
      final startX = i * (adjustedWidth + spacing);
      // The bottom triangles should start after the containers, with added spacing
      final bottomYStart = triangleHeight + spacing + containerHeight + spacing;

      path.moveTo(startX + adjustedWidth / 2,
          bottomYStart + triangleHeight); // Bottom center of the triangle
      path.lineTo(startX, bottomYStart); // Top left of the triangle
      path.lineTo(
          startX + adjustedWidth, bottomYStart); // Top right of the triangle
      path.close();
      canvas.drawPath(
          path, trianglePaint); // Use trianglePaint for red triangles
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
