import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/controller/customerResponse_controller.dart';
import 'package:sunshine_app/view/ipad12.dart';
import 'package:sunshine_app/view/ipad14.dart';
import 'package:sunshine_app/view/ipad15.dart';
import 'package:sunshine_app/view/ipad16.dart';

class Ipad13 extends StatelessWidget {
  const Ipad13({super.key});

  @override
  Widget build(BuildContext context) {
    void NavigatingConditions(CustomerController controller) {
      try {
        // Navigate based on selected customer
        if (controller.selectedNameId == '1') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Ipad14()));
        } else if (controller.selectedNameId == '3') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Ipad15()));
        }
      } catch (e) {
        log('Error occurred during navigation: $e');
        // Show error feedback to the user (optional)
      }
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30.0,
          ),
        
          SizedBox(
            height: 20.0,
          ),
          Text(
            'EMERGENCY CALL OUT',
            style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.0,
          ),
          const Row(
            children: [
              SizedBox(
                width: 40.0,
              ),
              Text(
                "Have you been called out for a specific line?",
                style: TextStyle(fontSize: 28.0, color: Colors.green),
              ),
            ],
          ),
          const Row(
            children: [
              SizedBox(
                width: 40.0,
              ),
              Text(
                "[select \"No\" if you've been directed to a multi-line station]",
                style: TextStyle(fontSize: 28.0, color: Colors.green),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(),
              MoreButtons(
                func: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Ipad16()));
                },
                buttonText: 'NO',
              ),
              Consumer<CustomerController>(
                builder: (context, controller, child) {
                return  MoreButtons(
                  func: () {
                    NavigatingConditions(controller);
                  },
                  buttonText: 'YES',
                );
                  
                },
                
              ),
              SizedBox(),
            ],
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .35,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [MoreButtons(buttonText: "Next", func: () {})],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Footer(isShowSettings: true)
        ],
      ),
    );
  }
}

class MoreButtons extends StatelessWidget {
  final VoidCallback func; // Use VoidCallback for the correct type
  String buttonText;
  MoreButtons({
    required this.buttonText,
    required this.func,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func, // Now it's the correct type
      child: Container(
        height: 80.0,
        width: 220.0,
        decoration: BoxDecoration(
          color: Colors.yellow.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
