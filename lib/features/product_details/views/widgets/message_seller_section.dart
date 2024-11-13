import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:product_details/core/views/buttons.dart';

import '../../../../main.dart';

class MessageSellerDialog extends StatelessWidget {
  const MessageSellerDialog({super.key});

  Future<void> _showThankYouNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'your_channel_id', // Channel ID
      'Your Channel Name', // Channel Name
      // 'Your Channel Description',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Thank you', // Notification Title
      'Thank you for Contacting Us', // Notification Body
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close Icon
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  context.maybePop();
                },
                child: const Icon(Icons.close, color: Colors.grey),
              ),
            ),

            TextField(
              controller: messageController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            PrimaryButton(
                label: 'Send  Message',
                onPressed: () {
                  _showThankYouNotification();
                  context.maybePop();
                })
          ],
        ),
      ),
    );
  }
}
