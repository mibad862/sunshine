import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/controller/ipad8_controller.dart';
import 'package:sunshine_app/view/releasevehicle.dart';
import 'package:sunshine_app/view/servicevehicle.dart';

class Refuel extends StatefulWidget {
  const Refuel({super.key, required this.isFromReleaseVehicle});
  final bool isFromReleaseVehicle;

  @override
  State<Refuel> createState() => _RefuelState();
}

class _RefuelState extends State<Refuel> {
  // Initial 7 digit value
  List<int> counterDigits =
      List.generate(7, (index) => 0); // Initialize with zeros
  List<int> initialOdometerDigits =
      List.generate(7, (index) => 0); // To store the initial odometer reading
  String updatedCounterValue = ''; // To store updated counter value as a string
  // Initial 3-digit value for percentage (max 100)
  List<int> percentageDigits = [0, 0, 0]; // Initially 000 = 0%
  List<int> initialFuelDigits = [0, 0, 0]; // To store the initial fuel value
  String updatedPercentageValue =
      "000"; // To store the updated percentage value
  // Variable to store the selected reason
  String selectedReason =
      ''; // Can be "Depot Bowser", "Fuel Card", or "Reimbursement"

  @override
  void initState() {
    final pro = Provider.of<Ipad8Controller>(context, listen: false);
    // Fetch the previous odometer reading from API
    pro.getPrevOdometerReadings(vehicleId: "1", context: context).then((value) {
      if (value != null && value.isNotEmpty) {
        // Parse the string from API to List<int>
        setState(() {
          counterDigits =
              value.split('').map((digit) => int.parse(digit)).toList();
          initialOdometerDigits =
              List.from(counterDigits); // Store initial odometer reading
        });
      }
    });
    super.initState();
  }

  // Function to increment the counter at a specific position
  void incrementDigit(int index) {
    setState(() {
      counterDigits[index]++;
      if (counterDigits[index] > 9) {
        counterDigits[index] = 0;
        // Carry over to the next digit
        if (index > 0) incrementDigit(index - 1);
      }
      // Update the string representation of the counter
      updateCounterString();
    });
  }

  // Function to decrement the counter at a specific position
  void decrementDigit(int index) {
    setState(() {
      counterDigits[index]--;
      if (counterDigits[index] < 0) {
        counterDigits[index] = 9;
        // Borrow from the next digit
        if (index > 0) decrementDigit(index - 1);
      }
      // Update the string representation of the counter
      updateCounterString();
    });
  }

  // Function to convert the counter list to string and save it
  void updateCounterString() {
    updatedCounterValue = counterDigits.join('');
    print(
        "Updated Odometer Value: $updatedCounterValue"); // You can save this value
  }

  // Function to increment the counter at a specific position
  void incrementFuelDigit(int index) {
    setState(() {
      int currentValue = _getCurrentValue();
      if (currentValue < 100) {
        percentageDigits[index]++;
        if (percentageDigits[index] > 9) {
          percentageDigits[index] = 0;
          // Carry over to the next digit
          if (index > 0) incrementDigit(index - 1);
        }
        _constrainToMaxValue();
        _updatePercentageString(); // Update the percentage string
      }
    });
  }

  // Function to decrement the counter at a specific position
  void decrementFuelDigit(int index) {
    setState(() {
      int currentValue = _getCurrentValue();
      if (currentValue > 0) {
        percentageDigits[index]--;
        if (percentageDigits[index] < 0) {
          percentageDigits[index] = 9;
          // Borrow from the next digit
          if (index > 0) decrementDigit(index - 1);
        }
        _constrainToMinValue();
        _updatePercentageString(); // Update the percentage string
      }
    });
  }

  // Get the current value of the percentage counter
  int _getCurrentValue() {
    return int.parse(percentageDigits.join(''));
  }

  // Ensure that the value doesn't go above 100
  void _constrainToMaxValue() {
    if (_getCurrentValue() > 100) {
      setState(() {
        percentageDigits = [1, 0, 0]; // Cap at 100
      });
    }
  }

  // Ensure that the value doesn't go below 0
  void _constrainToMinValue() {
    if (_getCurrentValue() < 0) {
      setState(() {
        percentageDigits = [0, 0, 0]; // Floor at 0
      });
    }
  }

  // Update the percentage value string
  void _updatePercentageString() {
    updatedPercentageValue = percentageDigits.join('');
    print(
        "Updated Percentage Value: $updatedPercentageValue"); // Print or save the value
  }

  // Function to handle selecting a reason and updating the selected reason
  void selectReason(String reason) {
    setState(() {
      selectedReason = reason;
    });
  }

  // Validate if all fields are filled before confirming
  void validateAndConfirm() {
    if (selectedReason.isEmpty) {
      toast("Please select a reason.");
      return;
    }
    if (_isOdometerNotUpdated()) {
      toast("Please update the odometer reading.");
      return;
    }
    if (_isFuelNotUpdated()) {
      toast("Please update the fuel added.");
      return;
    }
    // Proceed with confirmation logic (e.g., saving data or moving to next screen)
    if (widget.isFromReleaseVehicle) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Releasevehicle(
              fuel: updatedPercentageValue,
              odometer: updatedCounterValue,
              reason: selectedReason,
            ),
          ));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceVehicle(
              fuel: updatedPercentageValue,
              odometer: updatedCounterValue,
              reason: selectedReason,
            ),
          ));
    }
  }

  // Check if odometer has been updated by comparing with initial values
  bool _isOdometerNotUpdated() {
    for (int i = 0; i < counterDigits.length; i++) {
      if (counterDigits[i] != initialOdometerDigits[i]) {
        return false; // At least one digit has changed
      }
    }
    return true; // No digit has changed
  }

  // Check if fuel has been updated by comparing with initial values
  bool _isFuelNotUpdated() {
    for (int i = 0; i < percentageDigits.length; i++) {
      if (percentageDigits[i] != initialFuelDigits[i]) {
        return false; // At least one digit has changed
      }
    }
    return true; // No digit has changed
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityWrapper(
        bodyScreen: Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 15.0,
              ),
              Header(),
              const SizedBox(
                height: 15.0,
              ),
              //  SizedBox(height: MediaQuery.sizeOf(context).height*.09,),
              const Text(
                'REFUEL',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: const Text(
                          "ODOMETER READING",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      SizedBox(
                        width: 700, // Increased width to accommodate spacing
                        height: 250,

                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children:
                              List.generate(counterDigits.length, (index) {
                            return CounterWidget(
                              value: counterDigits[index],
                              onIncrement: () => incrementDigit(index),
                              onDecrement: () => decrementDigit(index),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => selectReason('Depot Bowser'),
                          child: Container(
                            height: 60,
                            width: 200,
                            decoration: BoxDecoration(
                              color: selectedReason == 'Depot Bowser'
                                  ? Colors.green
                                  : const Color.fromARGB(255, 133, 201, 233),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Center(
                              child: Text(
                                "DEPOT BOWSER",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        GestureDetector(
                          onTap: () => selectReason('Fuel Card'),
                          child: Container(
                            height: 60,
                            width: 200,
                            decoration: BoxDecoration(
                              color: selectedReason == 'Fuel Card'
                                  ? Colors.green
                                  : const Color.fromARGB(255, 133, 201, 233),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Center(
                              child: Text(
                                "FUEL CARD",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        GestureDetector(
                          onTap: () => selectReason('Reimbursement'),
                          child: Container(
                            height: 60,
                            width: 200,
                            decoration: BoxDecoration(
                              color: selectedReason == 'Reimbursement'
                                  ? Colors.green
                                  : const Color.fromARGB(255, 133, 201, 233),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Center(
                              child: Text(
                                "REIMBURSEMENT",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * .025),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: const Text(
                          "FUEL ADDED",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 450, // Increased width to accommodate spacing
                        height: 250,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children:
                              List.generate(percentageDigits.length, (index) {
                            return CounterWidget(
                              value: percentageDigits[index],
                              onIncrement: () => incrementFuelDigit(index),
                              onDecrement: () => decrementFuelDigit(index),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 60,
                            width: 200,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 133, 201, 233),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: const Center(
                              child: Text(
                                "Back",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30.0,
                        ),
                        InkWell(
                          onTap: validateAndConfirm,
                          child: Container(
                            height: 60,
                            width: 200,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 133, 201, 233),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: const Center(
                              child: Text(
                                "Confirm",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //  SizedBox(height: MediaQuery.sizeOf(context).height*.11),
              const Footer(isShowSettings: true),
            ],
          ),
        ),
      ),
    ));
  }
}

class CounterWidget extends StatelessWidget {
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CounterWidget({
    super.key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          color: Colors.blue,
          icon: const Icon(Icons.arrow_drop_up, size: 100),
          onPressed: onIncrement,
        ),
        Container(
          width: 50,
          height: 50,
          color: Colors.white,
          child: Center(
            child: Text(
              '$value',
              style: const TextStyle(fontSize: 40, color: Colors.black),
            ),
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          color: Colors.blue,
          icon: const Icon(Icons.arrow_drop_down, size: 100),
          onPressed: onDecrement,
        ),
      ],
    );
  }
}
