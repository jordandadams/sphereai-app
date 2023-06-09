import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPCode extends StatefulWidget {
  final Function(String) onCodeEntered;
  OTPCode({required this.onCodeEntered});
  
  @override
  _OTPCodeState createState() => _OTPCodeState();
}

class _OTPCodeState extends State<OTPCode> {
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> controllers = List.generate(6, (_) => TextEditingController());

  void nextFocus(int index, {bool reverse = false}) {
    if (reverse && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    } else if (!reverse && index < focusNodes.length - 1) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine the screen width and calculate the width of each container
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = (screenWidth - 100) / 6;
    final containerHeight = containerWidth;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          width: containerWidth,
          height: containerHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: focusNodes[index].hasFocus
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
            ),
          ),
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              counterText: '',
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                nextFocus(index, reverse: true);
              } else if (value.isNotEmpty) {
                nextFocus(index);
              }
              String enteredCode = controllers.map((e) => e.text).join('');
              widget.onCodeEntered(enteredCode);
            },
            inputFormatters: [
              // Allow only digits (0-9)
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
          ),
        );
      }),
    );
  }
}