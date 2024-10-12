import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/controller/customerResponse_controller.dart';
import 'package:sunshine_app/models/customerResponse_model.dart';

import 'package:sunshine_app/view/ipad12.dart';
import 'package:sunshine_app/view/ipad6.dart';

class Ipad11 extends StatefulWidget {
  const Ipad11({Key? key}) : super(key: key);

  @override
  State<Ipad11> createState() => _Ipad11State();
}

class _Ipad11State extends State<Ipad11> {
  @override
  void initState() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final controller = Provider.of<CustomerController>(context, listen: false);
    controller.getCustomers();
  });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerController>(
      builder: (context, controller, child) {
        // Handle error messages
        // if (controller.errorMessage != null) {
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(content: Text(controller.errorMessage!)),
        //     );
        //     controller.errorMessage = null; // Reset after displaying
        //   });
        // }

        return Scaffold(
          body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.0),
            // Header(
            //   navigation: () {
            //     Navigator.push(
            //         context, MaterialPageRoute(builder: (context) => Ipad12()));
            //   },
            // ),
            SizedBox(height: 20.0),
            Text(
              'EMERGENCY CALL OUT',
              style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                SizedBox(width: 40.0),
                Text(
                  "Customers?",
                  style: TextStyle(fontSize: 28.0, color: Colors.green),
                ),
              ],
            ),
            SizedBox(height: 20.0),

                     Expanded(
                        child:controller.isLoading == true && controller.customerResponse==null?
                        Center(child: CircularProgressIndicator()):
                        controller.isLoading == false && controller.customerResponse==null?
                        Center(child: Text('No customers available.')):
                        
                         ListView.builder(
                          itemCount:
                              controller.customerResponse!.customers.length,
                          itemBuilder: (context, index) {
                            var customer =
                                controller.customerResponse!.customers[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40.0, vertical: 10.0),
                              child: MoreButtons(
                                func: () {
                                  controller.setSelectedNameId(customer.id);
                                  // Define what happens when a customer button is pressed
                                  _onCustomerSelected();
                                },
                                buttonText: customer.name,
                              ),
                            );
                          },
                        ),
                      ),
                    
            SizedBox(height: MediaQuery.of(context).size.height * .1),
            const Align(
              alignment:Alignment.bottomCenter,
              child: Footer(isShowSettings: true)),
          ],
        )
       ,
        );
       
      },
    );
  }

  void _onCustomerSelected() async {
    // Navigate to IPAD12 with selected customer details
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Ipad12(),
      ),
    );
  }
}

class MoreButtons extends StatelessWidget {
  final VoidCallback func; // Use VoidCallback for the correct type
  final String buttonText;

  MoreButtons({
    required this.buttonText,
    required this.func,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: func, // Now it's the correct type
      child: Container(
        height: 80.0,
        width: 220.0,
        decoration: BoxDecoration(
          color: Colors.yellow.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
