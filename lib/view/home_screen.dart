import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunshine_app/colors/colors.dart';
import 'package:sunshine_app/components/footer.dart';
import 'package:sunshine_app/components/header.dart';
import 'package:sunshine_app/components/visibility_wrapper.dart';
import 'package:sunshine_app/controller/home_controller.dart';
import 'package:sunshine_app/controller/motion_detection_controller.dart';
import 'package:sunshine_app/view/password_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController =
      ScrollController(); // Add ScrollController

  @override
  void initState() {
    final pro = Provider.of<HomeController>(context, listen: false);
    pro.getAllDrivers();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
        .dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityWrapper(
      bodyScreen: Consumer<HomeController>(
        builder: (context, homeController, child) => Scaffold(
          body: Column(
            children: [
              const SizedBox(height: 20.0),
              Header(),
              const SizedBox(height: 25.0),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDriverList(homeController),
                    const Spacer(),
                    _buildVehicleStatus(homeController),
                  ],
                ),
              ),
              const Footer(isShowSettings: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDriverList(HomeController homeController) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Current Drivers",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Divider(thickness: 5.0),
            const SizedBox(height: 10.0),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.35,
              child: _buildDriverListView(homeController),
            ),
            const SizedBox(height: 15.0),
            Text(
              "Current Damage",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            Divider(thickness: 5.0),
            const SizedBox(height: 5.0),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      "Issue ${index + 1}",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30.0),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "View All",
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVehicleStatus(HomeController homeController) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.3,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Vehicle Status",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            Divider(thickness: 5.0),
            const SizedBox(height: 5.0),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.35,
              child: _buildVehicleStatusListView(homeController),
            ),
            const SizedBox(height: 15.0),
            Text(
              "Faults",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            Divider(thickness: 5.0),
            const SizedBox(height: 5.0),
            Expanded(
              child: homeController.isLoading == true &&
                      homeController.dashboardData == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : homeController.isLoading == false &&
                          homeController.dashboardData == null
                      ? const Center(
                          child: Text("No faults found..."),
                        )
                      : ListView.builder(
                          itemCount: homeController
                              .dashboardData!.vehicleFaults.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                homeController
                                    .dashboardData!.vehicleFaults[index].fault
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverListView(HomeController homeController) {
    return homeController.isLoading == true &&
            homeController.dashboardData == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : homeController.isLoading == false &&
                homeController.dashboardData == null
            ? const Center(
                child: Text("No drivers found..."),
              )
            : Scrollbar(
                thickness: 8.0,
                trackVisibility: true,
                interactive: true,
                controller: _scrollController,
                thumbVisibility: true,
                child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: homeController.dashboardData!.drivers.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PasswordScreen(
                              driverId: homeController
                                  .dashboardData!.drivers[index].id
                                  .toString(),
                              driverName:
                                  "${homeController.dashboardData!.drivers[index].firstName} ${homeController.dashboardData!.drivers[index].lastName}",
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: homeController
                                      .dashboardData!.drivers[index].color ==
                                  "dark"
                              ? AppColors.secondaryColor
                              : AppColors.primaryColor,
                        ),
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          "${homeController.dashboardData!.drivers[index].firstName} ${homeController.dashboardData!.drivers[index].lastName}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
  }

  Widget _buildVehicleStatusListView(HomeController homeController) {
    return homeController.isLoading == true &&
            homeController.dashboardData == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : homeController.isLoading == false &&
                homeController.dashboardData == null
            ? const Center(
                child: Text("No status found..."),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: homeController.dashboardData!.vehicleStatus.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        homeController.dashboardData!.vehicleStatus[index].name
                            .toString(),
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        homeController.dashboardData!.vehicleStatus[index].value
                            .toString(),
                        style: const TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.normal),
                      )
                    ],
                  );
                },
              );
  }
}
