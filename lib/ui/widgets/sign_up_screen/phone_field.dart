import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';

class PhoneField extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData? icon;

  const PhoneField({
    Key? key,
    required this.textController,
    required this.hintText,
    this.icon,
  }) : super(key: key);

  @override
  _PhoneFieldState createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  String _applyPhoneMask(String value) {
    final textLength = value.length;
    if (textLength == 0) return '';
    if (textLength <= 3) return '($value';
    if (textLength <= 6) return '(${value.substring(0, 3)})${value.substring(3)}';
    return '(${value.substring(0, 3)})${value.substring(3, 6)}-${value.substring(6, textLength)}';
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final iconColor = _isFocused ? colorScheme.primary : colorScheme.secondary;

    return TextField(
      controller: widget.textController,
      keyboardType: TextInputType.phone,
      focusNode: _focusNode,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only digits
        TextInputFormatter.withFunction((oldValue, newValue) {
          final newText = _applyPhoneMask(newValue.text);
          return TextEditingValue(
            text: newText,
            selection: TextSelection.collapsed(offset: newText.length),
          );
        }),
      ],
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: colorScheme.onSurface),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorScheme.secondary),
        ),
        suffixIcon: widget.icon != null ? Icon(widget.icon, color: iconColor) : null,
      ),
    );
  }
}
