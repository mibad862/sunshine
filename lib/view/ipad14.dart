import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/controller/ipad14_controller.dart';
import 'package:sunshine_app/view/ipad16.dart';

class Ipad14 extends StatefulWidget {
  const Ipad14({super.key});

  @override
  State<Ipad14> createState() => _Ipad14State();
}

class _Ipad14State extends State<Ipad14> {
  @override
  void initState() {
    super.initState();
    // Fetch VLine data when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VLineController>(context, listen: false).getVlines();
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityWrapper(
      bodyScreen: Scaffold(
        appBar: AppBar(
          title: const Text('V/Line Selection'),
        ),
        body: Consumer<VLineController>(
          builder: (context, vLineController, child) {
            // Display error messages using SnackBar if there's an error
            if (vLineController.errorMessage != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(vLineController.errorMessage!)),
                );
                vLineController.errorMessage = null; // Reset the error message
              });
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 18.0),
                const Text(
                  "Emergency Call Out",
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 17.0),
                const Row(
                  children: [
                    SizedBox(width: 80.0),
                    Text(
                      "Which V/Line line?",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 17.0),
                // Main content
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (vLineController.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        ); // Show loader while fetching data
                      } else if (vLineController.vLineResponse == null ||
                          vLineController.vLineResponse!.customers.isEmpty) {
                        return const Center(
                          child: Text("No vlines available"),
                        ); // Show message if no data is available
                      } else {
                        // Display the list of customers
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // 3 items per row
                            crossAxisSpacing: 5.0, // Space between columns
                            mainAxisSpacing: 5.0, // Space between rows
                            childAspectRatio:
                                3, // Adjust the ratio to fit your design
                          ),
                          itemCount:
                              vLineController.vLineResponse!.customers.length,
                          itemBuilder: (context, index) {
                            final customer =
                                vLineController.vLineResponse!.customers[index];
                            return
                                GestureDetector(
                                  onTap: () {
                                    vLineController.setSelectedNameId(customer.id); // Handle customer selection 
                                    
                                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Ipad16()));

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
                const Footer(isShowSettings: true),
              ],
            );
          },
        ),
      ),
    );
  }
}
