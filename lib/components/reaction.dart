import 'package:flutter/material.dart';

class Reaction {
  // Static method to show the dialog and return the selected image path
  static Future<String?> showDialogBox(BuildContext context) async {
    String? selectedImagePath;

    // Show the dialog and wait for the result
    await showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog from closing on tap outside
      builder: (BuildContext context) {
        // List of image paths for the emojis
        List<String> emojiImages = [
          'assets/images/like.png',
          'assets/images/love1.png',
          'assets/images/care.png',
          'assets/images/haha.png',
          'assets/images/wow.png',
          'assets/images/sad.png',
          'assets/images/angry.png',
        ];
        return _ReactionDialog(
          emojiImages: emojiImages,
          onEmojiSelected: (imagePath) {
            selectedImagePath = imagePath;
            Navigator.of(context).pop(); // Close the dialog when an emoji is selected
          },
        );
      },
    );

    return selectedImagePath; // Return the selected emoji image path
  }
}

class _ReactionDialog extends StatefulWidget {
  final List<String> emojiImages;
  final Function(String) onEmojiSelected; // Callback to pass back the selected emoji

  const _ReactionDialog({
    Key? key,
    required this.emojiImages,
    required this.onEmojiSelected,
  }) : super(key: key);

  @override
  __ReactionDialogState createState() => __ReactionDialogState();
}

class __ReactionDialogState extends State<_ReactionDialog> {
  List<double> _sizes = List.generate(7, (index) => 28.0); // Default size for all emojis

  // Reusable widget for each emoji button
  Widget emojiButton(String imagePath, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          for (int i = 0; i < 7; i++) {
            if (i != index) {
              _sizes[i] = 28;
            } else {
              _sizes[index] = (_sizes[index] == 28.0) ? 40.0 : 28.0;
            }
          }
        });

        // Wait for milliseconds before closing the dialog
        Future.delayed(Duration(milliseconds: 200), () {
          // Pass the selected image path to the main page
          widget.onEmojiSelected(imagePath);
        });

        print("Tapped emoji at index $index, new size = ${_sizes[index]}");
      },
      child: Container(
        width: _sizes[index],
        height: _sizes[index],
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: ClipOval(
          child: Image.asset(
            imagePath,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(8.0),
      content: SizedBox(
        height: 60, // Height of the dialog
        width: MediaQuery.of(context).size.width - 40, // Set the width
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget.emojiImages.length, (index) {
            return emojiButton(widget.emojiImages[index], index);
          }),
        ),
      ),
    );
  }
}
