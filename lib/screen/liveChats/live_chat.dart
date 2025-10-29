import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MessagingScreen extends StatefulWidget {
  const MessagingScreen({super.key});

  @override
  _MessagingScreenState createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final TextEditingController _messageController = TextEditingController();

  final String userId = "rakib123"; // Current user
  final String supportId = "emp123"; // Support or bot
  final String chatId = "rakib123_emp123"; // Unique chat ID

  @override
  void initState() {
    super.initState();
    checkAndSendWelcome(chatId, supportId, userId);
  }

  /// ✅ Send user message and assistant reply
  Future<void> sendMessage(String text) async {
    final chatRef = FirebaseFirestore.instance.collection('chats').doc(chatId);

    await chatRef.collection('messages').add({
      'text': text,
      'senderId': userId,
      'timestamp': FieldValue.serverTimestamp(),
      'isAuto': false,
    });

    await chatRef.set({
      'users': [userId, supportId],
      'lastMessage': text,
      'lastUpdated': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    // Reply after 1s
    Future.delayed(Duration(seconds: 1), () async {
      final reply = getAssistantReply(text);
      await chatRef.collection('messages').add({
        'text': reply,
        'senderId': supportId,
        'timestamp': FieldValue.serverTimestamp(),
        'isAuto': true,
      });

      await chatRef.set({
        'lastMessage': reply,
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    });
  }

  /// ✅ Predefined bot reply
  String getAssistantReply(String message) {
    final msg = message.toLowerCase();
    if (msg.contains("hi") || msg.contains("hello")) {
      return "Hello! 👋 How can I help you today?";
    } else if (msg.contains("problem") || msg.contains("issue")) {
      return "Sorry to hear that. Could you describe your issue?";
    } else if (msg.contains("thanks") || msg.contains("thank you")) {
      return "You're welcome! 😊";
    } else if (msg.contains("bye")) {
      return "Goodbye! Take care.";
    } else {
      return "Thanks for your message! We'll get back to you shortly.";
    }
  }

  /// ✅ Welcome message on first chat
  Future<void> checkAndSendWelcome(String chatId, String senderId, String receiverId) async {
    final messagesRef = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages');

    final snapshot = await messagesRef.get();

    if (snapshot.docs.isEmpty) {
      await messagesRef.add({
        'text': 'Hi 👋, how can I assist you today?',
        'senderId': senderId,
        'timestamp': FieldValue.serverTimestamp(),
        'isAuto': true,
      });

      await FirebaseFirestore.instance.collection('chats').doc(chatId).set({
        'users': [senderId, receiverId],
        'lastMessage': 'Hi 👋, how can I assist you today?',
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }
  }

  /// ✅ WhatsApp launcher
  void openWhatsApp(String phoneNumber, String message) async {
    final url = "https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not launch WhatsApp")),
      );
    }
  }

  /// ✅ Cleanup controller
  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messagesStream = FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat with Support"),
        actions: [
      IconButton(
      icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
      onPressed: () {
        openWhatsApp("918051208207", "Hi, I need help!");
      },
    ),

        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: messagesStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message['senderId'] == userId;

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.green : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          message['text'],
                          style: TextStyle(
                            color: isMe ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(hintText: "Type your message..."),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final text = _messageController.text.trim();
                    if (text.isNotEmpty) {
                      sendMessage(text);
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
