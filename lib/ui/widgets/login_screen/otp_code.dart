import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPCode extends StatefulWidget {
  @override
  _OTPCodeState createState() => _OTPCodeState();
}

class _OTPCodeState extends State<OTPCode> {
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> controllers = List.generate(4, (_) => TextEditingController());

  void nextFocus(int index) {
    if (index < focusNodes.length - 1) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine the screen width and calculate the width of each container
    final screenWidth = MediaQuery.of(context).size.width;
    final containerWidth = (screenWidth - 100) / 4;
    final containerHeight = containerWidth;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(4, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 1),
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
              if (value.isNotEmpty) {
                nextFocus(index);
              }
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
