import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/controller/ipad7_controller.dart';
import 'package:sunshine_app/view/refuel.dart';
import 'package:sunshine_app/view/servicevehicle.dart';

class Releasevehicle extends StatefulWidget {
  const Releasevehicle({super.key, this.fuel, this.odometer, this.reason});
  final String? fuel;
  final String? reason;
  final String? odometer;

  @override
  State<Releasevehicle> createState() => _ReleasevehicleState();
}

class _ReleasevehicleState extends State<Releasevehicle> {
  // Map to store answers with meaningful identifiers
  Map<String, String> answers = {};

  // A map to associate each question index with a meaningful identifier
  final Map<int, String> questionIdentifiers = {
    0: 'fuel',
    1: 'washed',
    2: 'dumbToilet',
    3: 'vaccum',
    4: 'windScreen',
    5: 'paintTyres',
    6: 'polishRims',
    7: 'cleanAC',
    8: 'washerFluid',
  };

  @override
  void initState() {
    afterBuildCreated(() {
      final pro = Provider.of<Ipad7Controller>(context, listen: false);
      pro.getQuestions(context: context).then((_) {
        setState(() {
          answers = {
            for (int i = 0; i < pro.allQuestions.length; i++)
              questionIdentifiers[i] ?? '': '' // Initialize with empty values
          };
        });
      });
      log("fuel : ${widget.fuel ?? ''}");
      log("reason : ${widget.reason ?? ''}");
      log("odometer : ${widget.odometer ?? ''}");
    });

    super.initState();
  }

  // Function to update the answer for a specific question by its identifier
  void updateAnswer(int index, String answer) {
    final identifier =
        questionIdentifiers[index]; // Get the identifier for the question
    if (identifier != null) {
      setState(() {
        answers[identifier] = answer; // Update the answer for that identifier
      });
      log("Answer for $identifier updated to: $answer");
    }
  }

  // Function to submit answers
  void submitAnswers() {
    String driverId = getStringAsync("driver_id");

    final pro = Provider.of<Ipad7Controller>(context, listen: false);

    // Collect the necessary parameters along with the answers
    pro.submitAnswers(
      driverId: driverId, // Replace with actual driverId
      vehicleId: "1", // Replace with actual vehicleId
      currentTime: DateTime.now(), // Replace with actual time if needed
      odometerReading: widget.odometer ?? '', // Pass the odometer reading
      fuelSource: widget.reason ?? '', // Pass the reason or fuel source
      fuel: widget.fuel ?? '', // Pass the fuel value
      context: context,
      cleanAC: answers["cleanAC"]!, // Using descriptive key
      washed: answers["washed"]!, // Using descriptive key
      dumbToilet: answers["dumbToilet"]!, // Using descriptive key
      paintTyres: answers["paintTyres"]!, // Using descriptive key
      polishRims: answers["polishRims"]!, // Using descriptive key
      vaccum: answers["vaccum"]!, // Using descriptive key
      washerFluid: answers["washerFluid"]!, // Using descriptive key
      windScreen: answers["windScreen"]!, // Using descriptive key
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Ipad7Controller>(
      builder: (context, ipad7Controller, child) => VisibilityWrapper(
        bodyScreen: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30.0,
              ),
              Header(
                navigation: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServiceVehicle()));
                },
              ),
              Text(
                "Release Vehicle",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.90,
                height: MediaQuery.sizeOf(context).width * 0.45,
                child: ipad7Controller.isLoading == true &&
                        ipad7Controller.allQuestions.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ipad7Controller.isLoading == false &&
                            ipad7Controller.allQuestions.isEmpty
                        ? const Center(
                            child: Text("No questions found..."),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: ipad7Controller.allQuestions.length,
                            itemBuilder: (context, index) {
                              return QuestionsTile(
                                isFuel: index == 0,
                                question: ipad7Controller
                                        .allQuestions[index].question ??
                                    "-",
                                isAcFilter: index == 7,
                                onAnswerSelected: (answer) => updateAnswer(
                                    index, answer), // Pass callback
                                selectedAnswer:
                                    answers[questionIdentifiers[index]] ??
                                        '', // Bind selected answer
                              );
                            },
                          ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 60.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                          color: Color(0xfffec103),
                          borderRadius: BorderRadius.circular(10.0)),
                      alignment: Alignment.center,
                      child: Text(
                        "Back",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      submitAnswers();
                    },
                    child: Container(
                      height: 60.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                          color: Color(0xfffec103),
                          borderRadius: BorderRadius.circular(10.0)),
                      alignment: Alignment.center,
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.1,
                  ),
                ],
              ),
              SizedBox(
                height: 35.0,
              ),
              const Footer(isShowSettings: true)
            ],
          ),
        ),
      ),
    );
  }
}

class QuestionsTile extends StatelessWidget {
  const QuestionsTile({
    super.key,
    required this.question,
    required this.isAcFilter,
    required this.isFuel,
    required this.onAnswerSelected,
    required this.selectedAnswer,
  });

  final String question;
  final bool isAcFilter;
  final bool isFuel;
  final Function(String) onAnswerSelected; // Callback to update answer
  final String selectedAnswer; // Selected answer for this question

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.45,
              child: Text(
                question,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
          if (isFuel) ...[
            SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.45,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          border: Border.all(color: Colors.black)),
                      height: 40.0,
                      width: 220.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          VerticalDivider(
                            color: Colors.white,
                            thickness: 2,
                          ),
                          VerticalDivider(
                            color: Colors.white,
                            thickness: 2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 40.0,
                        width: 110.0,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: const Center(
                          child: Text(
                            "Full",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Refuel(
                                isFromReleaseVehicle: true,
                              ),
                            ));
                      },
                      child: Container(
                        height: 40.0,
                        width: 110.0,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                          child: Text(
                            "Add Fuel",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ))
          ] else ...[
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.45,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => onAnswerSelected('Yes'), // Update answer
                    child: Container(
                      height: 40.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                        color: selectedAnswer == 'Yes'
                            ? Colors.orange
                            : Colors.green,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Center(
                        child: Text(
                          "Yes",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  if (isAcFilter) ...[
                    const SizedBox(
                      height: 40.0,
                      width: 180.0,
                    ),
                  ] else ...[
                    GestureDetector(
                      onTap: () => onAnswerSelected("Not Needed"),
                      child: Container(
                        height: 40.0,
                        width: 180.0,
                        decoration: BoxDecoration(
                          color: selectedAnswer == "Not Needed"
                              ? Colors.orange
                              : Colors.green,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Center(
                          child: Text(
                            "Not Needed",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(
                    width: 20.0,
                  ),
                  GestureDetector(
                    onTap: () => onAnswerSelected('No'), // Update answer
                    child: Container(
                      height: 40.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                        color: selectedAnswer == 'No'
                            ? Colors.orange
                            : Colors.green,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Center(
                        child: Text(
                          "No",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }
}
