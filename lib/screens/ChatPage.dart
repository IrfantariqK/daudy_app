import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];

  void _sendMessage() async {
    final String apiUrl = 'your_chat_api_endpoint'; // Replace with your actual chat API endpoint

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'message': _messageController.text,
        },
      );

      if (response.statusCode == 200) {
        // Message sent successfully, you can handle the response as needed
        print('Message sent: ${_messageController.text}');
        setState(() {
          _messages.add(_messageController.text);
          _messageController.clear();
        });
      } else {
        // Handle unsuccessful message send response
        print('Message send failed: ${response.body}');
      }
    } catch (error) {
      // Handle connection errors or other exceptions
      print('Error: $error');
    }
  }

  Future<void> _fetchMessages() async {
    final String apiUrl = 'your_chat_api_endpoint'; // Replace with your actual chat API endpoint

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        // Handle the fetched messages as needed
        setState(() {
          _messages.addAll(responseData.map((message) => message.toString()));
        });
      } else {
        // Handle unsuccessful message fetch response
        print('Message fetch failed: ${response.body}');
      }
    } catch (error) {
      // Handle connection errors or other exceptions
      print('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch messages when the page is loaded
    _fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          ElevatedButton(
            onPressed: _sendMessage,
            child: Text('Send'),
          ),
        ],
      ),
    );
  }
}
