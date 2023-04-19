import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class EmailInput extends StatefulWidget {
  final TextEditingController emailController;

  const EmailInput({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  @override
  _EmailInputState createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
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
      controller: widget.emailController,
      keyboardType: TextInputType.emailAddress,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: 'Email',
        hintStyle: TextStyle(color: colorScheme.onSurface),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorScheme.secondary),
        ),
        suffixIcon: Icon(Ionicons.mail, color: iconColor),
      ),
    );
  }
}