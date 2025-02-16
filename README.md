# Trashie: Smart Waste Management Mobile Application 

📦 Trashie
A AI-driven waste management mobile application that uses navigation features, AI chatbot along with camera sensing to solve optimize waste handling, promote recycling and reduce landfill waste. 

🚀 Features
- Real-Time Data for Navigation: Utilized data from ultrasonic sensor to detect if either the bins are full or not and to optimize collection route. 
- AI Chatbot: Integrates OpenAI's GPT model to provide conversational AI.
- Camera: Use the device's camera for detecting the items . 

🛠️ Project Setup
- Flutter SDK (>= 3.4.3 < 4.0.0)
- Dart SDK compatible with Flutter 3.4.3
- An IDE like VSCode or Android Studio
- A device or emulator for testing
- Circuit Setup: https://github.com/user-attachments/assets/e1e6da6e-5757-4553-a661-391e5d704d01 


📚 Dependencies
Core Dependencies: 
- flutter: The Flutter framework for building cross-platform applications.
- animated_bottom_navigation_bar: For smooth navigation transitions.
- flutter_riverpod: State management solution.
- camera: Access to device camera features.
- chat_gpt_sdk: To integrate OpenAI's GPT model
- flutter_dotenv: Manages environment variables securely.
Development Dependencies:
- flutter_test: For unit and widget testing.
- flutter_lints: To maintain consistent coding style.


🚀 Usage Instructions

1. Setting Up the Environment
Ensure you've created the .env file at the root of your project as described in the Installation section. The file should contain:
OPENAI_API_KEY=your_api_key_here
!!Replace your_api_key_here with your actual OpenAI API key.

2. Running the App on Android
- Connect a physical device or start an emulator/simulator.
- Run the following command: 
flutter run

3. Navigating the App
- Login page where an individual can either sign up as admin or user

Bottom Navigation Bar
The app has a bottom navigation bar with three main tabs:
- Home: User can view the real-time data to see if the status of the bins. Admin can also view it for route optimization purpose. 
- Camera: Only user has this feature to detect which bin should the waste goes to. 
- AI Chatbox: User and admin has this feature for educational purpose. 

4. Common Issues and Fixes
a. Missing API Key Error:
- Ensure the .env file is properly configured and not missing.
- Restart the app after setting the API key.
b. No Response from ChatBot:
- Double-check the OpenAI API key.
- Verify your internet connection.
