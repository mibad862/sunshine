import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/colors/colors.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/controller/auth_controller.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen(
      {super.key, required this.driverId, required this.driverName});
  final String driverName;
  final String driverId;
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  String _password = '';
  bool isLocked = false;

  // Function to handle digit input
  void _onDigitPress(String digit) {
    if (_password.length < 4) {
      setState(() {
        _password += digit;
      });
    }
  }

  // Function to handle backspace (cancel button)
  void _onCancelPress() {
    if (_password.isNotEmpty) {
      setState(() {
        _password = _password.substring(0, _password.length - 1);
      });
    }
  }

  // Function to handle password submission
  void _submitPassword() {
    if (_password.length == 4) {
      log("Password entered: $_password"); // Handle password logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle currentTextStyle = const TextStyle(
      //color: Color(0xff003B5C),
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    );
    String currentDateTime =
        DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Header(),
          /* Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Sunshine Scenic Tours", style: currentTextStyle),
              Text(currentDateTime, style: currentTextStyle),
              Text("8446AO", style: currentTextStyle),
            ],
          ),*/
          const SizedBox(
            height: 25.0,
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: '${widget.driverName}, ',
                style:
                    currentTextStyle.copyWith(color: AppColors.primaryColor)),
            TextSpan(
                text: 'Please Enter Your Password',
                style:
                    currentTextStyle.copyWith(color: AppColors.primaryColor)),
          ])),
      
          const SizedBox(
            height: 25.0,
          ),
          // Display the 4-digit input field
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              4,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      index < _password.length ? '*' : '',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
      
          // Numeric keypad (1-9)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First Row of Digits
                _buildButtonRow(['1', '2', '3']),
                const SizedBox(height: 20),
      
                // Second Row of Digits
                _buildButtonRow(['4', '5', '6']),
                const SizedBox(height: 20),
      
                // Third Row of Digits
                _buildButtonRow(['7', '8', '9']),
                const SizedBox(height: 50),
      
                // Cancel Button (acting as backspace)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _onCancelPress,
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(180, 80),
                        padding: EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        log("pin : $_password driverid : ${widget.driverId}");
                        Provider.of<AuthController>(context, listen: false)
                            .loginDriver(
                                driverId: widget.driverId,
                                pin: _password,
                                context: context);
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(180, 80),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        'Okay',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.07),
          const Footer(
            isShowSettings: false,
          ),
        ],
      ),
    );
  }

  // Build row of number buttons
  Widget _buildButtonRow(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits.map((digit) {
        return ElevatedButton(
          onPressed: () => _onDigitPress(digit),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(160.0, 80.0),
            padding: const EdgeInsets.all(20), // Adjust button size
          ),
          child: Text(
            digit,
            style: const TextStyle(fontSize: 24),
          ),
        );
      }).toList(),
    );
  }
}
