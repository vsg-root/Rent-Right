import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({
    Key? key,
    this.size = 24.0,
    this.color,
    this.onChanged,
    this.checkedColor = const Color(0xFF31546B),
  }) : super(key: key);

  final double size;
  final Color? color;
  final Color checkedColor;
  final Function(bool?)? onChanged;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => isChecked = !isChecked);
        widget.onChanged?.call(isChecked);
      },
      child: AnimatedContainer(
        duration:
            Duration(milliseconds: 200), // Duração da animação em milissegundos
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.color ?? const Color(0xFF0E2433),
            width: 2.0,
          ),
          shape: BoxShape.circle,
          color: isChecked ? widget.checkedColor : Colors.transparent,
        ),
      ),
    );
  }
}
