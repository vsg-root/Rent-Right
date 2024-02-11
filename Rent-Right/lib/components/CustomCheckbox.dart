import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({
    Key? key,
    required this.icon,
    this.value = false,
    this.size = 24.0,
    this.color,
    this.onChanged,
    this.checkedColor = const Color(0xFF31546B),
  }) : super(key: key);

  final String icon;
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
          padding: const EdgeInsets.all(5),
          duration: Duration(milliseconds: 200),
          width: widget.size,
          height: widget.size,
          decoration: ShapeDecoration(
            color: _value ? widget.checkedColor : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: SvgPicture.asset(widget.icon,
              colorFilter: ColorFilter.mode(
                  _value ? Colors.white : Colors.black, BlendMode.srcIn)),
        ));
  }
}
