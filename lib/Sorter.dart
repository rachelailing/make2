import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:make/Ai.dart';
import 'package:make/NearestBin.dart';

class Sorter extends StatefulWidget {
  const Sorter({super.key});

  @override
  State<Sorter> createState() => _SorterState();
}

class _SorterState extends State<Sorter> {
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
        MaterialPageRoute(builder: (context) => const NearestBin()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ChatBot()),
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
                  color: Colors.teal),
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
            decoration: BoxDecoration(
              color: Colors.lightGreen.shade50,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
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
