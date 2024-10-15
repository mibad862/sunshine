import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/controller/driver_portal_controller.dart';
import 'package:sunshine_app/controller/ipad8_controller.dart';
import 'package:sunshine_app/view/ipad3.dart';

class OdometerScreen extends StatefulWidget {
  const OdometerScreen({super.key});

  @override
  State<OdometerScreen> createState() => _OdometerScreenState();
}

class _OdometerScreenState extends State<OdometerScreen> {
  // Initial 7 digit value
  List<int> counterDigits =
      List.generate(7, (index) => 0); // Initialize with zeros
  String updatedCounterValue = ''; // To store updated counter value as a string
  String initialCounterValue = ''; // Store the initial odometer reading
  bool _hasConfirmedLowerValue = false;

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
          initialCounterValue = value;
        });
      }
    });
    super.initState();
  }

  // Function to validate and update the counter string
  void validateAndUpdateCounterString() {
    String newValue = counterDigits.join('');

    if (newValue.length == initialCounterValue.length) {
      int newInt = int.parse(newValue);
      int initialInt = int.parse(initialCounterValue);

      if (newInt < initialInt && !_hasConfirmedLowerValue) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Warning'),
              content: Text(
                  'Are you sure you want to enter a value less than the initial odometer reading?'),
              actions: [
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    setState(() {
                      counterDigits = initialCounterValue
                          .split('')
                          .map((digit) => int.parse(digit))
                          .toList();
                    });
                  },
                ),
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    setState(() {
                      updatedCounterValue = newValue;
                      _hasConfirmedLowerValue =
                          true; // Set flag to remember confirmation
                    });
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        ).then((value) {
          if (value ?? false) {
            setState(() {
              updatedCounterValue = newValue;
            });
          }
        });
      } else {
        setState(() {
          updatedCounterValue = newValue;
        });
      }
    } else {
      setState(() {
        updatedCounterValue = newValue;
      });
    }
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
      validateAndUpdateCounterString();
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
      validateAndUpdateCounterString();
    });
  }

  // Function to convert the counter list to string and save it
  void updateCounterString() {
    updatedCounterValue = counterDigits.join('');
    print(
        "Updated Odometer Value: $updatedCounterValue"); // You can save this value
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityWrapper(
      bodyScreen: Consumer<Ipad8Controller>(
        builder: (context, ipad8Controller, child) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 30.0),
                  Header(),
                  const SizedBox(height: 30),
                  const Text(
                    'Odometer Reading',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 422,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(counterDigits.length, (index) {
                        return CounterWidget(
                          value: counterDigits[index],
                          onIncrement: () => incrementDigit(index),
                          onDecrement: () => decrementDigit(index),
                        );
                      }),
                    ),
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * .03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 60,
                        width: 200,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 133, 201, 233),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Center(
                            child: Text(
                          "Back",
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(width: 60.0),
                      InkWell(
                        onTap: () async {
                          bool? result = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Clock Off Confirmation'),
                                content:
                                    Text('Are you sure you want to clock off?'),
                                actions: [
                                  TextButton(
                                    child: Text('No'),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Yes'),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                ],
                              );
                            },
                          );

                          if (result != null && result) {
                            String driverId = getStringAsync("driver_id");

                            // Clock off logic here
                            final pro = Provider.of<DriverPortalController>(
                                context,
                                listen: false);
                            await pro
                                .clockOff(
                                    driverId: driverId,
                                    vehicleId: "1",
                                    context: context)
                                .then(
                              (value) {
                                // Navigate back to IPAD 3
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserStatus(),
                                    ));
                              },
                            );
                          } else if (result == false) {
                            // Return to IPAD 3 without clocking off
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserStatus(),
                                ));
                          }
                        },
                        child: Container(
                          height: 60,
                          width: 200,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 133, 201, 233),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Center(
                              child: Text(
                            "Confirm",
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      const SizedBox(width: 100.0),
                    ],
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * .11),
                  const Footer(isShowSettings: true),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
          icon: const Icon(Icons.arrow_drop_up, size: 140),
          onPressed: onIncrement,
        ),
        Container(
          width: 80,
          height: 80,
          color: Colors.yellow,
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
          icon: const Icon(Icons.arrow_drop_down, size: 140),
          onPressed: onDecrement,
        ),
      ],
    );
  }
}
