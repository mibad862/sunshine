import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/footer.dart';
import '../components/header.dart';
import '../components/visibility_wrapper.dart';
import '../controller/ipad18_controller.dart';

class Ipad18 extends StatelessWidget {
  const Ipad18({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => Ipad18Controller()..fetchCallOutData(),
      child: Scaffold(
        body: Consumer<Ipad18Controller>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (provider.errorMessage.isNotEmpty) {
              return Center(child: Text(provider.errorMessage));
            }

            final data = provider.callOutData;
            if (data == null) {
              return Center(child: Text('No data available'));
            }

            return VisibilityWrapper(
                bodyScreen: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30.0,
                    ),
                    Header(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "${data.lineName} Line",
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .5,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Starting at",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20.0),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        borderRadius: BorderRadius.circular(5.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Center(
                                        child: Text(
                                          data.startingStation,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 20.0),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Next Station",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20.0),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        borderRadius: BorderRadius.circular(5.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Center(
                                        child: Text(
                                          data.nextStation,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 20.0),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .5,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Pax Count",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(width: 10),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: provider.incrementPaxCount,
                                    child: Container(
                                      height: 35,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            topLeft: Radius.circular(10)),
                                      ),
                                      child: Icon(
                                        Icons.plus_one,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 35,
                                    width: 55,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                    ),
                                    child: Text(provider.paxCounter.toString()),
                                  ),
                                  SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: provider.decrementPaxCount,
                                    child: Container(
                                      height: 35,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                      ),
                                      child: Icon(
                                        Icons.exposure_minus_1,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      data.reason,
                      style: TextStyle(fontSize: 24.0),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * .5,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Destination Station",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20.0),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        borderRadius: BorderRadius.circular(5.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Center(
                                        child: Text(
                                          data.destinationStation,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 20.0),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Stopping Pattern",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20.0),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        borderRadius: BorderRadius.circular(5.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Center(
                                        child: Text(
                                          "${data.stoppingPattern} Station",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold, fontSize: 20.0),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 240.0,
                        ),
                        InkWell(
                          onTap: (){
                            provider.arrivedStation(
                              data.emergencyCallOutId,
                              data.nextStationId,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  "Arrive\n${data.nextStation}",
                                  style:
                                  TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * .5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10.0)),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Center(
                                      child: Text(
                                        "BACK",
                                        style: TextStyle(
                                            fontSize: 20.0, fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10.0)),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Center(
                                      child: Text(
                                        "END TRIP",
                                        style: TextStyle(
                                            fontSize: 20.0, fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 240.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(
                                child: Text(
                                  "SHOW MAPS",
                                  style: TextStyle(
                                      fontSize: 20.0, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    const Footer(isShowSettings: true),
                  ],
                ));
          },
        ),
      ),
    );
  }
}






class CustomDesgin extends StatelessWidget {
  const CustomDesgin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          iconSize: 100.0,
          icon: Icon(Icons.arrow_drop_up),
        ),
        CircleAvatar(
          radius: 40.0,
          backgroundColor: Colors.blue,
        ),
        IconButton(
          iconSize: 100.0,
          onPressed: () {},
          icon: Icon(
            Icons.arrow_drop_down,
          ),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
