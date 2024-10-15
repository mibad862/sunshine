import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/controller/ipad4_controller.dart';
import 'package:sunshine_app/controller/ipad5_controller.dart';
import 'package:sunshine_app/view/ipad3.dart';

class Earlywhy extends StatefulWidget {
  const Earlywhy({super.key, this.expectedClockInTime, this.jobId});
  final DateTime? expectedClockInTime;
  final String? jobId;

  @override
  State<Earlywhy> createState() => _EarlywhyState();
}

class _EarlywhyState extends State<Earlywhy> {
  late Timer _timer; // Timer to update the countdown every second
  Duration _remainingTime = Duration(); // The remaining time for countdown

  @override
  void initState() {
    super.initState();
    // Calculate the initial remaining time
    if (widget.expectedClockInTime != null) {
      _remainingTime = widget.expectedClockInTime!.difference(DateTime.now());
    }

    // Start a timer to update the remaining time every second
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        // Recalculate the remaining time every second
        if (widget.expectedClockInTime != null) {
          _remainingTime =
              widget.expectedClockInTime!.difference(DateTime.now());
        }
      });
    });
  }

  // Format the remaining time into HH:mm:ss format
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  String selectedManager = '';

  // Function to show the dialog with options
  Future<void> _showManagerDialog() async {
    String? selected = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose a Manager',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOption('Pino'),
              _buildOption('Dom'),
              _buildOption('Josh'),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
        );
      },
    );
    String driverId = getStringAsync("driver_id");

    if (selected != null) {
      setState(() {
        selectedManager = selected;
        Provider.of<Ipad5Controller>(context, listen: false).clockIn(
            driverId: driverId,
            clockStatus: "Early",
            jobId: widget.jobId!,
            manager: selected,
            reason: "Manager Approved",
            context: context);
      });
    }
  }

  // Helper function to build each option
  Widget _buildOption(String name) {
    return ListTile(
      title: Text(name, style: TextStyle(fontSize: 20)),
      onTap: () {
        Navigator.of(context)
            .pop(name); // Return the selected option and close the dialog
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String driverId = getStringAsync("driver_id");

    return VisibilityWrapper(
      bodyScreen: Column(
        children: [
          SizedBox(
            height: 30.0,
          ),
          Header(),
          SizedBox(
            height: 80.0,
          ),
          Text(
            "You're attempting to clock in ${_formatDuration(_remainingTime)} early... why?",
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 120.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              reusableButtons(
                  buttonName: "MANAGER APPROVED",
                  onTap: () {
                    _showManagerDialog();
                  }),
              SizedBox(
                width: 30.0,
              ),
              reusableButtons(
                  buttonName: "EMERGENCY CALL IN - V/LINE",
                  onTap: () {
                    Provider.of<Ipad5Controller>(context, listen: false)
                        .clockIn(
                            driverId: driverId,
                            clockStatus: "Early",
                            jobId: widget.jobId ?? "",
                            reason: "Emergency Call In V/Line",
                            context: context);
                  }),
              SizedBox(
                width: 30.0,
              ),
              reusableButtons(
                  buttonName: "EMERGENCY CALL IN - METRO",
                  onTap: () {
                    Provider.of<Ipad5Controller>(context, listen: false)
                        .clockIn(
                            driverId: driverId,
                            clockStatus: "Early",
                            jobId: widget.jobId ?? "",
                            reason: "Emergency Call In Metro",
                            context: context);
                  })
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              reusableButtons(
                  buttonName: "CLOCK IN AT EXPECTED TIME",
                  onTap: () {
                    Provider.of<Ipad4Controller>(context, listen: false)
                        .clockIn(
                            driverId: driverId,
                            time: widget.expectedClockInTime ?? DateTime.now(),
                            clockStatus: "Ok",
                            jobId: widget.jobId ?? "",
                            context: context);
                  }),
              SizedBox(
                width: 30.0,
              ),
              reusableButtons(
                  buttonName: "FILL IN FOR ANOTHER DRIVER", onTap: () {}),
              SizedBox(
                width: 30.0,
              ),
              reusableButtons(
                  buttonName: "   CANCEL   ",
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserStatus(),
                        ));
                  })
            ],
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .33,
          ),
          Footer(isShowSettings: true)
        ],
      ),
    );
  }
}

class reusableButtons extends StatelessWidget {
  String buttonName;
  final VoidCallback onTap;
  reusableButtons({
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
          color: const Color.fromARGB(255, 133, 201, 233),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title;
  String value;
  ReusableRow({
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
