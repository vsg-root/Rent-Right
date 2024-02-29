import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumericInput extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int initialValue;
  final ValueChanged<int> onChanged;

  const NumericInput({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<NumericInput> createState() => _NumericInputState();
}

class _NumericInputState extends State<NumericInput> {
  int _value = 0;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
    controller.text = _value.toString();
  }

  void _increment() {
    setState(() {
      _value = _value < widget.maxValue ? _value + 1 : _value;
      controller.text = _value.toString();
    });
    widget.onChanged(_value);
  }

  void _decrement() {
    setState(() {
      _value = _value > widget.minValue ? _value - 1 : _value;
      controller.text = _value.toString();
    });
    widget.onChanged(_value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: _decrement,
          icon: const Icon(Icons.remove, size: 16),
        ),
        SizedBox(
          width: 30,
          child: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            // Atualiza o valor do textfield
            controller: controller,
            onSubmitted: (value) {
              if (value.isEmpty) {
                controller.text = '0';
              }
              _value = int.parse(controller.text);
              widget.onChanged(_value);
            },
          ),
        ),
        IconButton(
          onPressed: _increment,
          icon: const Icon(Icons.add, size: 16),
        ),
      ],
    );
  }
}
