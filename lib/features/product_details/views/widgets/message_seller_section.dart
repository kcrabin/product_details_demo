import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:product_details/core/service/local_notification_service.dart';
import 'package:product_details/core/utils/size_config.dart';
import 'package:product_details/core/views/app_toast.dart';
import 'package:product_details/core/views/buttons.dart';

class MessageSellerDialog extends StatelessWidget {
  const MessageSellerDialog({super.key});

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
            SizeConfig(context).verticalSpaceSmall(),
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
              label: 'Send Message',
              onPressed: () async {
                if (messageController.text.trim().isEmpty) {
                  showFailureToast('Please enter a message before sending.');
                } else {
                  // Send the message if the text field is not empty
                  FirebaseAPI().sendFirebaseMessage('Thank you for Contacting Us');
                  context.maybePop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
