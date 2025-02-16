import 'dart:async';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:make/NearestBin.dart';
import 'package:make/Sorter.dart';

class ChatBotAdmin extends StatefulWidget {
  const ChatBotAdmin({super.key});

  @override
  State<ChatBotAdmin> createState() => _ChatBotAdminState();
}

class _ChatBotAdminState extends State<ChatBotAdmin> {
  int _selectedIndex = 2;
  TextEditingController adminPromptText = TextEditingController();
  late OpenAI openAI;
  Future<CompleteResponse?>? _adminResponseFuture;
  final openaiApiKey = dotenv.env['OPENAI_API_KEY'];

  @override
  void initState() {
    openAI = OpenAI.instance.build(
      token: openaiApiKey,
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 20),
        connectTimeout: const Duration(seconds: 20),
      ),
      enableLog: true,
    );
    super.initState();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _onSendPressed() {
    final request = CompleteText(
      prompt: adminPromptText.text,
      maxTokens: 200,
      model: Gpt3TurboInstruct(),
    );

    setState(() {
      _adminResponseFuture = openAI.onCompletion(request: request);
      adminPromptText.clear();
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
                  child: Image(image: AssetImage('assets/images/robot.jpg')),
                ),
                SizedBox(height: 10),
                Text(
                  "AI Chatbot",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Hi Admin,",
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
                color: Colors.red.shade50,
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
                    controller: adminPromptText,
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
                  Expanded(child: _buildAdminResponse()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminResponse() {
    return FutureBuilder<CompleteResponse?>(
      future: _adminResponseFuture,
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
