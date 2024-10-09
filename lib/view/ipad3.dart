import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/controller/driver_portal_controller.dart';
import 'package:sunshine_app/view/ipad4.dart';

class UserStatus extends StatefulWidget {
  const UserStatus({super.key});

  @override
  State<UserStatus> createState() => _UserStatusState();
}

class _UserStatusState extends State<UserStatus> {
  String driverId = getStringAsync("driver_id");

  @override
  void initState() {
    final pro = Provider.of<DriverPortalController>(context, listen: false);
    pro.getDriverStatus(driverId: driverId, vehicleId: "7", context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle currentTextStyle = const TextStyle(
      // color: Color(0xff003B5C),
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    );
    return VisibilityWrapper(bodyScreen: Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        Header(
  navigation: () {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => Ipad4())
    );
  },
),
const SizedBox(
            height: 20.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: MediaQuery.sizeOf(context).width * .38,
                  child: Text(
                    'Status: clock off',
                    style: currentTextStyle,
                  )),
              SizedBox(
                  width: MediaQuery.sizeOf(context).width * .19,
                  child: Text(
                    'Today\'s Jobs',
                    style: currentTextStyle,
                  )),
              SizedBox(
                  width: MediaQuery.sizeOf(context).width * .19,
                  child: Text(
                    'Be at',
                    style: currentTextStyle,
                  )),
              SizedBox(
                  width: MediaQuery.sizeOf(context).width * .19,
                  child: Text(
                    'In',
                    style: currentTextStyle,
                  )),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              SizedBox(
                  width: MediaQuery.sizeOf(context).width * .38,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              customButton(
                                ontap: () {},
                                buttonText: 'Clock On',
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              customButton(
                                  buttonText: 'TAKE/ACCEPT 8446AO',
                                  ontap: () {}),
                              const SizedBox(
                                height: 20.0,
                              ),
                              customButton(
                                  buttonText: 'REPORT DEFECT', ontap: () {}),
                              const SizedBox(
                                height: 20.0,
                              ),
                              customButton(
                                  buttonText: 'VIEW SCHEDULE', ontap: () {}),
                              const SizedBox(
                                height: 20.0,
                              ),
                              customButton(
                                  buttonText: 'LOCK OUT VEHICLE',
                                  ontap: () {})
                            ],
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: [
                              customButton(
                                ontap: () {},
                                buttonText: 'START BREAK',
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              customButton(
                                  buttonText: 'REQUEST TIME OFF',
                                  ontap: () {}),
                              const SizedBox(
                                height: 20.0,
                              ),
                              customButton(
                                  buttonText: 'ADD/AJUST BREAKS',
                                  ontap: () {}),
                              const SizedBox(
                                height: 20.0,
                              ),
                              customButton(
                                  buttonText: 'UPDATE STATUSES',
                                  ontap: () {}),
                              const SizedBox(
                                height: 20.0,
                              ),
                              customButton(
                                  buttonText: 'VIEW MAPS', ontap: () {})
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                  width: MediaQuery.sizeOf(context).width * .19,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customButton(buttonText: 'BXE 94', ontap: () {}),
                      const SizedBox(
                        height: 120.0,
                      ),
                      customButton(buttonText: 'Unplanned', ontap: () {})
                    ],
                  )),
              SizedBox(
                  //  width: MediaQuery.sizeOf(context).width*.19,
                  child: customButton(
                      buttonText: "Southern Cross", ontap: () {})),
              SizedBox(
                  width: MediaQuery.sizeOf(context).width * .19,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customButton(buttonText: "24 m 59 s", ontap: () {}),
                      const SizedBox(
                        height: 240.0,
                      ),
                      customButton(buttonText: "LOGOUT", ontap: () {}),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => Releasevehicle()),
                      //     );
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 15.0, vertical: 8.0),
                      //     child: Container(
                      //       height: MediaQuery.sizeOf(context).height / 20,
                      //       width: MediaQuery.sizeOf(context).width * 0.18,
                      //       decoration: BoxDecoration(
                      //           color: Colors.grey.withOpacity(0.5),
                      //           borderRadius: BorderRadius.circular(10)),
                      //       child: const Center(
                      //         child: Text(
                      //           "Next",
                      //           style: TextStyle(
                      //               color: Colors.white, fontSize: 14.0),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  )),
            ],
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * .07,
          ),
          const Footer(isShowSettings: true)
        ],
      ),
     ) );
  }
}

class customButton extends StatelessWidget {
  Function ontap;
  String buttonText;
  customButton({
    required this.buttonText,
    required this.ontap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ontap,
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 229, 204, 123),
            borderRadius: BorderRadius.circular(8.0)),
        height: 80.0,
        width: 160.0,
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
