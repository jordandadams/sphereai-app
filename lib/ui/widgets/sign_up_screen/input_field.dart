import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class InputField extends StatefulWidget {
  final TextEditingController textController;
  final String hintText; // hintText parameter
  final IconData? icon; // icon parameter (nullable)

  const InputField({
    Key? key,
    required this.textController,
    required this.hintText, // hintText parameter
    this.icon, // icon parameter
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
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
      keyboardType: TextInputType.emailAddress,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: widget.hintText, // Use the hintText parameter
        hintStyle: TextStyle(color: colorScheme.onSurface),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorScheme.secondary),
        ),
        suffixIcon: widget.icon != null ? Icon(widget.icon, color: iconColor) : null, // Use the icon parameter
      ),
    );
  }
}