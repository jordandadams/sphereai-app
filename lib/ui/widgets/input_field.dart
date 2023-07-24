import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class TextInput extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData icon;

  const TextInput({
    Key? key,
    required this.textController,
    required this.hintText,
    required this.icon,
  }) : super(key: key);

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    // Add a listener to the focus node to detect focus changes
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the widget is disposed
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconColor = _isFocused ? colorScheme.primary : colorScheme.secondary;

    return TextField(
      controller: widget.textController,
      keyboardType: TextInputType.text,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: colorScheme.onSurface),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorScheme.secondary),
        ),
        suffixIcon: Icon(widget.icon, color: iconColor),
      ),
    );
  }
}