import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:make/AiAdmin.dart';
import 'package:make/Dashboard.dart';

class Sorter2 extends StatefulWidget {
  const Sorter2({super.key});

  @override
  State<Sorter2> createState() => _SorterState2();
}

class _SorterState2 extends State<Sorter2> {
  CameraController? _cameraController;
  bool isCameraInitialized = false;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController =
        CameraController(cameras.first, ResolutionPreset.medium);
    await _cameraController!.initialize();
    setState(() {
      isCameraInitialized = true;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ChatBotAdmin()),
      );
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Camera Scanner",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 254, 202, 199)),
            ),
          ),
          Expanded(
            child: Center(
              child: isCameraInitialized
                  ? CameraPreview(_cameraController!)
                  : const CircularProgressIndicator(),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 251, 202, 209),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                const Text(
                  "Detected Item: Hyaluronic Acid Serum",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  "Recycling Bin: Blue (Plastic)",
                  style: TextStyle(fontSize: 16, color: Colors.teal.shade700),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: "Sense"),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble), label: "ChatBot"),
        ],
        backgroundColor: Colors.purple.shade50,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
