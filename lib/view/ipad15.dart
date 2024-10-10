import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/controller/ipad15_controller.dart';
import 'package:sunshine_app/view/ipad12.dart';
import 'package:sunshine_app/view/ipad16.dart';

class Ipad15 extends StatefulWidget {
  const Ipad15({super.key});

  @override
  State<Ipad15> createState() => _Ipad15State();
}

class _Ipad15State extends State<Ipad15> {
    void initState() {
    super.initState();
    // Fetch VLine data when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MetroLineController>(context, listen: false).getMetrolines();
    });
  }
  @override
  Widget build(BuildContext context) {
    return VisibilityWrapper(bodyScreen: Scaffold(
      body: Consumer<MetroLineController>(
        builder: (context, controller, child) {
           // Display error messages using SnackBar if there's an error
            if (controller.errorMessage != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(controller.errorMessage!)),
                );
                controller.errorMessage = null; // Reset the error message
              });
            }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.0,
              ),
              

              SizedBox(
                height: 20.0,
              ),
              Text(
                "Emergency Call Out",
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 80.0,
                  ),
                  Text(
                    "Why metro line?",
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
               Expanded(
                  child: Builder(
                    builder: (context) {
                      if (controller.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        ); // Show loader while fetching data
                      } else if (controller.metroLineResponse == null ||
                          controller.metroLineResponse!.customers.isEmpty) {
                        return const Center(
                          child: Text("No metro lines available"),
                        ); // Show message if no data is available
                      } else {
                        // Display the list of customers
                        return GridView.builder(
                          gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, // 3 items per row
                            crossAxisSpacing: 5.0, // Space between columns
                            mainAxisSpacing: 5.0, // Space between rows
                            childAspectRatio: 3, // Adjust the ratio to fit your design
                          ),
                          itemCount: controller.metroLineResponse!.customers.length,
                          itemBuilder: (context, index) {
                            final customer = controller.metroLineResponse!.customers[index];
                            return GestureDetector(
                              onTap: () {
                                controller.setSelectedNameId(customer.id); // Handle customer selection
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Selected: ${customer.name}')),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 20.0),
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.yellow.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Center(
                                  child: Text(
                                    customer.name,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 18.0),
           
              const Footer(isShowSettings: true)
            ],
          );
        },
      ),
    ));
  }
}

