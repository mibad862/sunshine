import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'dart:convert';

import 'package:sunshine_app/config/app_config.dart';

class Ipad20 extends StatefulWidget {
  const Ipad20({
    super.key,
    required this.startingAtStation,
    required this.destinationStation,
    required this.startingAtStationId,
    required this.destinationStationId,
  });

  final String startingAtStation;
  final String destinationStation;
  final String startingAtStationId;
  final String destinationStationId;

  @override
  _Ipad20State createState() => _Ipad20State();
}

class _Ipad20State extends State<Ipad20> {
  List<String> stationStatuses = List.generate(15, (_) => '');
  List<Map<String, dynamic>> stations = [];
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchStations();
  }

  Future<void> fetchStations() async {
    setState(() {
      isLoading = true;
    });

    print('Starting Station ID: ${widget.startingAtStationId}');
    print('Destination Station ID: ${widget.destinationStationId}');

    const url = "https://api.g00r.com.au/API/getStoppingPatternStations";
    final body = {
      "serverKey": AppConfig.serverKey,
      "startingStationId": widget.startingAtStationId,
      "destinationStationId": widget.destinationStationId,
    };

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        errorMessage = 'Authentication token not found';
        return;
      }

      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: json.encode(body));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            // Initialize the stations list with 'id' and default 'reason'
            stations = List<Map<String, dynamic>>.from(
                data['stations'].map((station) => {
                      "id": station['stationId'],
                      "name": station['name'],
                      "reason": "", // initially empty
                    }));
            stationStatuses = List.generate(stations.length, (_) => '');
          });
        } else {
          setState(() {
            errorMessage = 'Failed to fetch stations';
          });
        }
      } else {
        setState(() {
          errorMessage = 'Error: ${response.statusCode}';
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Failed to connect to server';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _updateStationStatus(int index) {
    setState(() {
      // Update station status based on current value
      switch (stationStatuses[index]) {
        case '':
          stationStatuses[index] = 'Required';
          stations[index]['reason'] =
              'Required'; // update the reason in stations
          break;
        case 'Required':
          stationStatuses[index] = 'Set Down';
          stations[index]['reason'] =
              'Set Down'; // update the reason in stations
          break;
        case 'Set Down':
          stationStatuses[index] = 'Requested';
          stations[index]['reason'] =
              'Requested'; // update the reason in stations
          break;
        case 'Requested':
          stationStatuses[index] = '';
          stations[index]['reason'] = ''; // clear the reason
          break;
      }
    });
  }

  void _navigateBack() {
    // Pass back the stations list with only those that have valid reasons
    final filteredStations =
        stations.where((station) => station['reason'] != '').toList();

    print(filteredStations);
    Navigator.pop(context, filteredStations);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stopping Pattern')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20.0),
                      const Text(
                        'Stopping Pattern',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * .14,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.green.shade100,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text(
                                        widget.startingAtStation,
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  const Text(
                                    "STARTING AT",
                                    style: TextStyle(fontSize: 16.0),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Wrap(
                                  spacing: 16.0,
                                  runSpacing: 16.0,
                                  children:
                                      List.generate(stations.length, (index) {
                                    return _buildStationCard(index);
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: _navigateBack,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.yellow,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(
                                  'BACK',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Row(
                              children: [
                                const Text(
                                  "DEST",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                const SizedBox(width: 20.0),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.green.shade100,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text(
                                        widget.destinationStation,
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20.0),
                                GestureDetector(
                                  onTap: _navigateBack,
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.yellow,
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text(
                                        'SAVE',
                                        style: TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget _buildStationCard(int index) {
    String status = stationStatuses[index];
    bool isActive = status != '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            _updateStationStatus(index);
          },
          child: Container(
            alignment: Alignment.center,
            width: 140,
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: isActive ? Colors.green.shade300 : Colors.pink.shade300,
            ),
            child: Text(
              stations[index]['name'] ?? 'Station ${index + 1}',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        GestureDetector(
          onTap: () {
            _updateStationStatus(index);
          },
          child: Container(
            alignment: Alignment.center,
            width: 140,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.green.shade100,
            ),
            child: Text(
              status.isEmpty ? ' ' : status,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
