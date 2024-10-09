import 'package:flutter/material.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/view/message.dart';
import 'package:sunshine_app/view/releasevehicle.dart';

class Refuel extends StatelessWidget {
  const Refuel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VisibilityWrapper(bodyScreen: Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Column(
            
            children: [
              const SizedBox(height: 20.0,),
                Header(
  navigation: () {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) =>Releasevehicle())
    );
  },
),
                const SizedBox(height: 20.0,),
              //  SizedBox(height: MediaQuery.sizeOf(context).height*.09,),
              const Text(
                'REFUEL',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
               const SizedBox(height: 20.0,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 Column(
                   children: [
                    const Text("ODOMETER READING",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 30.0,),
                     SizedBox(
                                     width: 500, // Increased width to accommodate spacing
                                     height: 200,
                                     child: CustomPaint(
                      painter: OdometerPainter(),
                                     ),
                                   ),
                   ],
                 ),
                 Column(children: [
                   Container(height: 60,width: 200,
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: const Center(
          child: Text("DEPOT BOWSER"),
        ),
        ),
         SizedBox(height: 20.0,),
         Container(height: 60,width: 200,
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: const Center(
          child: Text("FUEL"),
        ),
        ),
         const SizedBox(height: 20.0,),
         Container(height: 60,width: 200,
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: const Center(
          child: Text("REIMBURSEMENT"),
        ),
        ),
                 ],)

              ],
             ),
               SizedBox(height: MediaQuery.sizeOf(context).height*.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       const Text("FUEL ADDED",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 30.0,),
                     SizedBox(
                                     width: 500, // Increased width to accommodate spacing
                                     height: 200,
                                     child: CustomPaint(
                      painter: OdometerSmallPainter(),
                                     ),
                                   ),
                    ],
                  ),
                  
                  Column(
                   
                    children: [
                          
                          Container(height: 60,width: 200,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: const Center(
                            child: Text("Back"),
                          ),
                          ),
                          const SizedBox(height: 20.0,),
                          Container(height: 60,width: 200,
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: const Center(child: Text("Confirm"),),
                          ),
                          const SizedBox(width: 100.0,),
                  ],),
                ],
              ),
              //  SizedBox(height: MediaQuery.sizeOf(context).height*.11),
              const Footer(isShowSettings: true),
            ],
          ),
        ),
      ),
     ) );
  }
}

class OdometerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint object for red triangles
    final trianglePaint = Paint()
      ..color = Colors.blue.withOpacity(0.7) // Red for triangles
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    // Paint object for yellow boxes
    final boxPaint = Paint()
      ..color = Colors.white // Yellow for boxes
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final triangleHeight = size.height / 4;
    final triangleWidth = size.width / 7;
    final containerHeight = size.height / 4;
    final spacing = 10.0; // Spacing between triangles and boxes

    // Adjusted triangle width for spacing
    final adjustedWidth = (size.width - (6 * spacing)) / 7;

    // Drawing top triangles (with spacing)
    for (int i = 0; i < 7; i++) {
      final path = Path();
      final startX = i * (adjustedWidth + spacing);
      path.moveTo(startX + adjustedWidth / 2, 0); // Top center
      path.lineTo(startX, triangleHeight);         // Bottom left
      path.lineTo(startX + adjustedWidth, triangleHeight); // Bottom right
      path.close();
      canvas.drawPath(path, trianglePaint); // Use trianglePaint for red triangles
    }

    // Drawing containers (with spacing)
    for (int i = 0; i < 7; i++) {
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
    for (int i = 0; i < 7; i++) {
      final path = Path();
      final startX = i * (adjustedWidth + spacing);
      // The bottom triangles should start after the containers, with added spacing
      final bottomYStart = triangleHeight + spacing + containerHeight + spacing; 

      path.moveTo(startX + adjustedWidth / 2, bottomYStart + triangleHeight); // Bottom center of the triangle
      path.lineTo(startX, bottomYStart);    // Top left of the triangle
      path.lineTo(startX + adjustedWidth, bottomYStart); // Top right of the triangle
      path.close();
      canvas.drawPath(path, trianglePaint); // Use trianglePaint for red triangles
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  
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
      ..color = Colors.white // Yellow for boxes
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final triangleHeight = size.height / 4;
    final triangleWidth = size.width / 7;
    final containerHeight = size.height / 4;
    final spacing = 10.0; // Spacing between triangles and boxes

    // Adjusted triangle width for spacing
    final adjustedWidth = (size.width - (6 * spacing)) / 7;

    // Drawing top triangles (with spacing)
    for (int i = 0; i < 4; i++) {
      final path = Path();
      final startX = i * (adjustedWidth + spacing);
      path.moveTo(startX + adjustedWidth / 2, 0); // Top center
      path.lineTo(startX, triangleHeight);         // Bottom left
      path.lineTo(startX + adjustedWidth, triangleHeight); // Bottom right
      path.close();
      canvas.drawPath(path, trianglePaint); // Use trianglePaint for red triangles
    }

    // Drawing containers (with spacing)
    for (int i = 0; i < 4; i++) {
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
    for (int i = 0; i < 4; i++) {
      final path = Path();
      final startX = i * (adjustedWidth + spacing);
      // The bottom triangles should start after the containers, with added spacing
      final bottomYStart = triangleHeight + spacing + containerHeight + spacing; 

      path.moveTo(startX + adjustedWidth / 2, bottomYStart + triangleHeight); // Bottom center of the triangle
      path.lineTo(startX, bottomYStart);    // Top left of the triangle
      path.lineTo(startX + adjustedWidth, bottomYStart); // Top right of the triangle
      path.close();
      canvas.drawPath(path, trianglePaint); // Use trianglePaint for red triangles
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  
  }
}
