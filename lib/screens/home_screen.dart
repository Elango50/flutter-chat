// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/custom_bottom_nav_bar.dart';
import '../models/chat_message.dart';
import '../config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ChatMessage>> _chatMessages;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _chatMessages = fetchChatMessages(); // Fetch chat messages on init
  }

  Future<List<ChatMessage>> fetchChatMessages() async {
    final response = await http.get(Uri.parse(AppConfig.apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((message) => ChatMessage.fromJson(message))
          .toList();
    } else {
      throw Exception('Failed to load chat messages');
    }
  }

  // Simulate sending a message
  Future<void> sendMessage(String message) async {
    // Here, you'd typically call the backend API to send the message
    // In this example, we'll just print it out for simulation.
    print('Sending message: $message');
    _messageController.clear(); // Clear the input field after sending
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Microsoft Teams Clone'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Add notification action
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Add settings action
            },
          ),
        ],
      ),
      drawer: NavigationDrawer(
        children: [],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<ChatMessage>>(
              future: _chatMessages,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No chat messages'));
                }

                final chatMessages = snapshot.data!;
                return ListView.builder(
                  reverse: true, // Show latest messages at the bottom
                  itemCount: chatMessages.length,
                  itemBuilder: (context, index) {
                    final chatMessage = chatMessages[index];
                    bool isMe =
                        chatMessage.sender == "You"; // Adjust as per your logic

                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        padding: const EdgeInsets.all(12.0),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blueAccent : Colors.grey[300],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft:
                                isMe ? Radius.circular(12) : Radius.circular(0),
                            bottomRight:
                                isMe ? Radius.circular(0) : Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: isMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              chatMessage.content,
                              style: TextStyle(
                                color: isMe ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${chatMessage.timestamp.hour}:${chatMessage.timestamp.minute}',
                              style: TextStyle(
                                color: isMe ? Colors.white70 : Colors.black54,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      sendMessage(_messageController.text);
                    }
                  },
                ),
              ],
            ),
          ),
          CustomBottomNavBar(),
        ],
      ),
    );
  }
}
