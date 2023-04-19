import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController passwordController;

  const PasswordInput({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;
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

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText; // Toggle the value of _obscureText
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconColor = _isFocused ? colorScheme.primary : colorScheme.secondary;

    return TextField(
      controller: widget.passwordController,
      obscureText: _obscureText,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Ionicons.eye : Ionicons.eye_off,
            color: iconColor,
          ),
          onPressed: _toggleObscureText,
        ),
      ),
    );
  }
}