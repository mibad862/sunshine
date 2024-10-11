import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/controller/customerResponse_controller.dart';
import 'package:sunshine_app/view/ipad11.dart';
import 'package:sunshine_app/view/ipad13.dart';
import 'package:sunshine_app/view/ipad14.dart';
import 'package:sunshine_app/view/ipad15.dart';

class Ipad12 extends StatefulWidget {
  const Ipad12({super.key});

  @override
  State<Ipad12> createState() => _Ipad12State();
}

class _Ipad12State extends State<Ipad12> {
  // Variables for hours and minutes
  int hour = 0;
  int minute = 0;
  bool isLoading = false;

  void _setTimeAndNavigate(CustomerController controller, String time) {
    log('Setting time: $time');

    try {
      // Set selected time
      controller.setSelectedTime(time);

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

  // Increment/decrement functions for hours and minutes
  void incrementHour() {
    setState(() {
      if (hour < 23) hour++;
    });
  }

  void decrementHour() {
    setState(() {
      if (hour > 0) hour--;
    });
  }

  void incrementMinute() {
    setState(() {
      if (minute < 59) minute++;
    });
  }

  void decrementMinute() {
    setState(() {
      if (minute > 0) minute--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityWrapper(
      bodyScreen: Consumer<CustomerController>(
        builder: (context, controller, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30.0),
              const Text(
                "EMERGENCY CALL OUT",
                style: TextStyle(fontSize: 24.0),
              ),
              const SizedBox(height: 20.0),
              const Text(
                "When did the call-out begin?",
                style: TextStyle(fontSize: 20.0, color: Colors.green),
              ),
              const SizedBox(height: 20.0),

              // Now button to set current time
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                 



                  TextButton(
                      onPressed: () {
                           TimeOfDay currentTime = TimeOfDay.now();
                        String formattedTime =
                            '${currentTime.hour}:${currentTime.minute.toString().padLeft(2, '0')}';
                        log('hehe$formattedTime');

                        controller.setSelectedTime(formattedTime);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Ipad13()));
                    
                      },
                      child: Container(
                         height: 90,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10.0)),
                        child: Center(child: const Text("Now",style: TextStyle(color: Colors.black),)))),
                  const SizedBox(width: 50.0),

                  // Custom Time Input (Hours and Minutes)
                  SizedBox(
                    width: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Hours input with custom UI
                        _buildTimeAdjuster(
                          value: hour,
                          label: 'HH',
                          onIncrement: incrementHour,
                          onDecrement: decrementHour,
                        ),
                        const SizedBox(width: 10.0),
                        // Minutes input with custom UI
                        _buildTimeAdjuster(
                          value: minute,
                          label: 'MM',
                          onIncrement: incrementMinute,
                          onDecrement: decrementMinute,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),

              // Display selected customer name
              Text(
                controller.selectedNameId.isNotEmpty
                    ? 'Selected Customer: ${controller.selectedNameId}'
                    : "No customer selected",
                style: const TextStyle(color: Colors.black, fontSize: 17),
              ),
              const SizedBox(height: 30.0),

              // Navigation buttons (Back and Confirm/Next)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 
                  TextButton(
                      onPressed: () {
                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Ipad11()));
                    
                      },
                      child: Container(
                         height: 90,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10.0)),
                        child: Center(child: const Text("Back",style: TextStyle(color: Colors.black),)))),
                  const SizedBox(height: 20.0),

                
                  TextButton(
                      onPressed: () {
                        // Get the entered time from the input fields
                        String enteredTime =
                            '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
                        log('ha${enteredTime}');
                        _setTimeAndNavigate(controller, enteredTime);
                      },
                      child: Container(
                         height: 90,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10.0)),
                        child: Center(child: const Text("Next",style: TextStyle(color: Colors.black),))))
                ],
              ),
              const SizedBox(height: 30.0),
              Footer(isShowSettings: true)
            ],
          );
        },
      ),
    );
  }

  // Custom widget to build time adjuster for hours and minutes
  Widget _buildTimeAdjuster({
    required int value,
    required String label,
    required Function onIncrement,
    required Function onDecrement,
  }) {
    return Column(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_drop_up, size: 40),
          onPressed: () => onIncrement(),
        ),
        Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            value.toString().padLeft(2, '0'),
            style: TextStyle(fontSize: 30),
          ),
        ),
        IconButton(
          icon: Icon(Icons.arrow_drop_down, size: 40),
          onPressed: () => onDecrement(),
        ),
      ],
    );
  }
}
