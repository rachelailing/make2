import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final List<Map<String, dynamic>> bins = [
    {'location': 'Block A', 'status': 'Not Full', 'distance': 0.5},
    {'location': 'Block B', 'status': 'Full', 'distance': 1.2},
    {'location': 'Cafeteria', 'status': 'Not Full', 'distance': 0.8},
    {'location': 'Library', 'status': 'Full', 'distance': 1.5},
  ];

  @override
  Widget build(BuildContext context) {
    // Filter to only show full bins & sort by nearest
    List<Map<String, dynamic>> optimizedBins = bins
        .where((bin) => bin['status'] == 'Full')
        .toList()
      ..sort((a, b) => a['distance'].compareTo(b['distance']));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    "Hi, Arleen",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 254, 133, 125)),
                  ),
                  Text(
                    "Optimized Collection Route",
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Middle Section: Optimized Route Display
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/robot.jpg', height: 100),
                  const SizedBox(height: 10),
                  const Text(
                    "Optimized Trash Collection Route",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  const Icon(Icons.route, size: 40, color: Colors.black),
                  const SizedBox(height: 10),

                  // Check if there are bins to collect from
                  optimizedBins.isNotEmpty
                      ? Column(
                          children: optimizedBins.map((bin) {
                            return ListTile(
                              leading:
                                  const Icon(Icons.delete, color: Colors.red),
                              title: Text(
                                bin['location'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle:
                                  Text("Distance: ${bin['distance']} km away"),
                            );
                          }).toList(),
                        )
                      : const Text(
                          "No bins require collection at the moment.",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
