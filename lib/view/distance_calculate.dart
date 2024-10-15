import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/controller/datetime_controller.dart';
import 'package:sunshine_app/controller/ipad4_controller.dart';
import 'package:sunshine_app/view/earlywhy.dart';

class DistanceCalculate extends StatefulWidget {
  const DistanceCalculate({super.key});

  @override
  State<DistanceCalculate> createState() => _DistanceCalculateState();
}

class _DistanceCalculateState extends State<DistanceCalculate> {
  Timer? _timer; // Timer to update every second
  Duration difference = Duration(); // Store the difference
  bool isNegative = false; // To track if the difference is negative
  String clockInStatus = "NOT OK"; // Status for clock-in check

  @override
  void initState() {
    afterBuildCreated(() {
      final pro = Provider.of<Ipad4Controller>(context, listen: false);
      pro.getDriverLatestJobs(driverId: "1", context: context).then(
        (value) {
          // Start the timer to update the difference every second
          _startTimer();
        },
      );
    });

    super.initState();
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Calculate the difference between the expected time and the current time
      final now = DateTime.now();
      final jobTime = Provider.of<Ipad4Controller>(context, listen: false)
              .latestJob
              ?.time ??
          now;

      setState(() {
        // Calculate the difference
        difference = now.difference(jobTime);

        // Check if the difference is negative (i.e., if the user clocks in before the expected time)
        isNegative = difference.isNegative;

        // Calculate the time that is 10 minutes before the expected time
        final earlyClockInTime = jobTime.subtract(const Duration(minutes: 10));

        // Update the clock-in status based on the current time compared to jobTime and earlyClockInTime
        if (now.isAfter(jobTime)) {
          // User clocks in after expected time, "NOT OK"
          clockInStatus = "NOT OK";
        } else if (now.isAfter(earlyClockInTime) && now.isBefore(jobTime)) {
          // User clocks in within 10 minutes before expected time, "YES OK"
          clockInStatus = "YES OK";
        } else if (now.isBefore(earlyClockInTime)) {
          // User clocks in before 10 minutes earlier than expected time, "OK"
          clockInStatus = "OK";
        }

        // If the difference is negative, convert it to positive for display purposes
        if (isNegative) {
          difference = difference.abs();
        }
      });
    });
  }

  // Function to format Duration into +HH:mm:ss or -HH:mm:ss based on the difference
  String _formatDurationWithSign(Duration duration, bool isNegative) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    // Add + or - sign based on the isNegative flag
    final sign = isNegative ? '-' : '+';
    return "$sign$hours:$minutes:$seconds";
  }

  TimeOfDay? selectedTime; // Variable to store selected time for clock-in
  // Function to show a time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(), // Default to current time
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
      // Convert TimeOfDay to DateTime and call the clockIn method
      final now = DateTime.now();
      final selectedDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          picked.hour,
          picked.minute); // Combining selected time with today's date

      // Assuming we use selected time for clocking in
      final pro = Provider.of<Ipad4Controller>(context, listen: false);
      pro.clockIn(
        driverId: getStringAsync("driver_id"),
        clockStatus: "Adjusted",
        time: selectedDateTime,
        jobId: pro.latestJob?.id.toString() ?? "",
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String driverId = getStringAsync("driver_id");

    String currentDateTime = context.watch<DateTimeProvider>().currentDateTime;
    return VisibilityWrapper(
      bodyScreen: Consumer<Ipad4Controller>(
        builder: (context, ipad4Controller, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.0,
            ),
            Header(),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Status: Clocked off",
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            if (ipad4Controller.isLoading) ...[
              Center(
                child: CircularProgressIndicator(),
              )
            ] else ...[
              ReusableRow(
                title: 'Current Time',
                value: currentDateTime,
              ),
              SizedBox(
                height: 20.0,
              ),
              if (ipad4Controller.latestJob != null) ...[
                ReusableRow(
                  title: 'Expected Login Time',
                  value: ipad4Controller.latestJob != null
                      ? DateFormat('HH:mm:ss - d MMM yyyy').format(
                          ipad4Controller.latestJob!.time ?? DateTime.now())
                      : "N/A",
                ),
                SizedBox(
                  height: 20.0,
                ),
                ReusableRow(
                  title: 'Difference',
                  value: _formatDurationWithSign(difference, isNegative),
                ),
              ] else ...[
                Center(
                  child: Text(
                    "No job has been found for you.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ],
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .1,
            ),
            Row(
              children: [
                SizedBox(
                  width: 235.0,
                ),
                ReusableButtons(
                  buttonName: 'Clock In Now',
                  onTap: () {
                    if (clockInStatus == "OK") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Earlywhy(
                              jobId: ipad4Controller.latestJob!.id.toString(),
                              expectedClockInTime:
                                  ipad4Controller.latestJob!.time ??
                                      DateTime.now(),
                            ),
                          ));
                    } else if (clockInStatus == "YES OK") {
                      ipad4Controller.clockIn(
                          driverId: driverId,
                          clockStatus: "Ok",
                          jobId: ipad4Controller.latestJob?.id.toString() ?? "",
                          time: DateTime.now(),
                          context: context);
                    } else {
                      ipad4Controller.clockIn(
                          driverId: driverId,
                          clockStatus: "Late",
                          jobId: ipad4Controller.latestJob?.id.toString() ?? "",
                          time: DateTime.now(),
                          context: context);
                    }
                  },
                ),
                SizedBox(width: 30.0),
                ReusableButtons(
                    buttonName: "Clock In At Expected Time",
                    onTap: () {
                      ipad4Controller.clockIn(
                          driverId: driverId,
                          clockStatus: "Ok",
                          time:
                              ipad4Controller.latestJob!.time ?? DateTime.now(),
                          jobId: ipad4Controller.latestJob?.id.toString() ?? "",
                          context: context);
                    }),
                SizedBox(width: 30.0),
                ReusableButtons(
                    buttonName: "Adjust Start Time",
                    onTap: () {
                      _selectTime(
                          context); // Show time picker for adjusting start time
                    }),
              ],
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .21,
            ),
            SizedBox(
                width: 250.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 60.0),
                  child: ReusableButtons(
                      buttonName: "Back",
                      onTap: () {
                        Navigator.pop(context);
                      }),
                )),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .13,
            ),
            Footer(isShowSettings: true)
          ],
        ),
      ),
    );
  }
}

class ReusableButtons extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTap;
  const ReusableButtons({
    required this.buttonName,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: Text(
              buttonName,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title;
  final String value;
  const ReusableRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.green, fontSize: 20.0),
            ),
            SizedBox(
              width: 30.0,
            ),
            Text(
              value,
              style: TextStyle(color: Colors.green, fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
