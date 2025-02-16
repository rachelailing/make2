import 'dart:async';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:make/NearestBin.dart';
import 'package:make/Sorter.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});
  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  int _selectedIndex = 2;
  TextEditingController userPromptText = TextEditingController();
  late OpenAI openAI;
  Future<CompleteResponse?>? _translateFuture;
  // Access the API key securely
  final openaiApiKey = dotenv.env['OPENAI_API_KEY'];

  @override
  void initState() {
    openAI = OpenAI.instance.build(
        token: openaiApiKey,
        baseOption: HttpSetup(
            receiveTimeout: const Duration(seconds: 20),
            connectTimeout: const Duration(seconds: 20)),
        enableLog: true);
    super.initState();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });

      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NearestBin()),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Sorter()),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatBot()),
        );
      }
    }
  }

  void _onSendPressed() {
    final request = CompleteText(
        prompt: userPromptText.text,
        maxTokens: 200,
        model: Gpt3TurboInstruct());

    setState(() {
      _translateFuture = openAI.onCompletion(request: request);
      userPromptText.clear();
    });
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
            child: Column(
              children: [
                SizedBox(
                    width: 150,
                    child: Image(image: AssetImage('assets/images/robot.jpg'))),
                SizedBox(height: 10),
                Text(
                  "AI Chatbot",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Hi Arleen,",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: Container(
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
                    "ASK AI",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: userPromptText,
                    decoration: InputDecoration(
                      hintText: "Text here...",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _onSendPressed,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Make the response scrollable
                  Expanded(child: _buildResponse()),
                ],
              ),
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

  Widget _buildResponse() {
    return FutureBuilder<CompleteResponse?>(
      future: _translateFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final text = snapshot.data?.choices.last.text;
          return SingleChildScrollView(
            child: Text(
              text ?? 'No response',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          );
        } else {
          return const Text('Awaiting input...');
        }
      },
    );
  }
}
