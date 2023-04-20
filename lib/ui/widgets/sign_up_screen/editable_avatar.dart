import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class EditableAvatar extends StatefulWidget {
  const EditableAvatar({Key? key}) : super(key: key);

  @override
  _EditableAvatarState createState() => _EditableAvatarState();
}

class _EditableAvatarState extends State<EditableAvatar> {
  String? _avatarImagePath;

  Future<void> _pickImage() async {
    // Implement image picking and uploading logic here
    // Set the '_avatarImagePath' variable to the new image path
    // For example, you can use the image_picker package to pick an image
    // and then use the path of the picked image to update '_avatarImagePath'
    // For demonstration purposes, we will use a placeholder image path
    setState(() {
      _avatarImagePath = 'assets/img/new_image.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(
              _avatarImagePath ?? 'assets/img/logo.png',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Ionicons.pencil,
                  color: Theme.of(context).colorScheme.background,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
