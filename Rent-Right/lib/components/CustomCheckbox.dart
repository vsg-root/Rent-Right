import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({
    Key? key,
    this.value = false,
    this.size = 24.0,
    this.color,
    this.onChanged,
    this.checkedColor = const Color(0xFF31546B),
  }) : super(key: key);

  final bool value; // Valor inicial da checkbox
  final double size;
  final Color? color;
  final Color checkedColor;
  final ValueChanged<bool>? onChanged;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _value; // Valor interno da checkbox

  @override
  void initState() {
    super.initState();
    _value = widget.value; // Inicializando o valor interno com o valor passado
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _value = !_value;
        });
        widget.onChanged?.call(_value);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.color ?? const Color(0xFF0E2433),
            width: 2.0,
          ),
          shape: BoxShape.circle,
          color: _value ? widget.checkedColor : Colors.transparent,
        ),
      ),
    );
  }
}
