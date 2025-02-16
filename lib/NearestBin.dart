import 'package:flutter/material.dart';
import 'package:make/Ai.dart';
import 'package:make/Sorter.dart';

class NearestBin extends StatefulWidget {
  const NearestBin({super.key});

  @override
  State<NearestBin> createState() => _NearestBinState();
}

class _NearestBinState extends State<NearestBin> {
  int myIndex = 0;

  final List<Map<String, dynamic>> bins = [
    {'location': 'Block A', 'status': 'Not Full', 'distance': 0.5},
    {'location': 'Block B', 'status': 'Full', 'distance': 1.2},
    {'location': 'Cafeteria', 'status': 'Not Full', 'distance': 0.8},
    {'location': 'Library', 'status': 'Full', 'distance': 1.5},
  ];

  @override
  Widget build(BuildContext context) {
    bins.sort((a, b) => a['distance'].compareTo(b['distance']));

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
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
                        color: Colors.teal),
                  ),
                  Text(
                    "Seri Iskandar Residency",
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Middle section with bin info
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/robot.jpg', height: 100),
                  const SizedBox(height: 10),
                  const Text(
                    "Nearest Available Bins",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.teal),
                  ),
                  const SizedBox(height: 10),
                  const Icon(Icons.location_pin, size: 40, color: Colors.black),
                  const SizedBox(height: 10),
                  Column(
                    children: bins.map((bin) {
                      return ListTile(
                        leading: Icon(
                          bin['status'] == 'Full' ? Icons.error : Icons.check,
                          color: bin['status'] == 'Full'
                              ? Colors.red
                              : Colors.green,
                        ),
                        title: Text(bin['location'],
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(
                            "Status: ${bin['status']} - ${bin['distance']} km away"),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 1) {
            // Clicking "Sense" navigates to Sorter
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Sorter()),
            );
          } else if (index == 2) {
            // Clicking "Sense" navigates to Sorter
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatBot()),
            );
          }
        },
        currentIndex: myIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: "Sense"),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble), label: "ChatBot"),
        ],
        backgroundColor: Colors.purple.shade50,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
