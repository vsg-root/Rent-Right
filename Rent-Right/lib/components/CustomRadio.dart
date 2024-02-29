import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';

class RadioItem<T> extends StatefulWidget {
  final String label;
  final String icon;
  final Color unselectedColor;
  final Color selectedColor;
  final double unselectedHeight;
  final double unselectedWidth;
  final double selectedHeight;
  final double selectedWidth;
  final ValueChanged<bool>? onChanged;
  final T value;

  RadioItem({
    Key? key,
    required this.label,
    required this.icon,
    required this.unselectedColor,
    required this.selectedColor,
    required this.unselectedHeight,
    required this.selectedHeight,
    required this.unselectedWidth,
    required this.selectedWidth,
    required this.value,
    this.onChanged,
  });

  @override
  State<RadioItem> createState() => _RadioItemState();
}

class _RadioItemState<T> extends State<RadioItem<T>> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        RadioGroup.of<T>(context).select(widget.value);
      },
      child: Row(
        children: [
          SvgPicture.asset(
            widget.icon,
            height: RadioGroup.of<T>(context)._selectedValue == widget.value
                ? widget.selectedHeight
                : widget.unselectedHeight,
            width: RadioGroup.of<T>(context)._selectedValue == widget.value
                ? widget.selectedWidth
                : widget.unselectedWidth,
            colorFilter: ColorFilter.mode(
              RadioGroup.of<T>(context)._selectedValue == widget.value
                  ? widget.selectedColor
                  : widget.unselectedColor,
              BlendMode.srcIn,
            ),
          ),
          if (widget.label.isNotEmpty) ...[
            const SizedBox(width: 8.0),
            Text(widget.label),
          ],
        ],
      ),
    );
  }
}

// Classe para agrupar os radio buttons
class RadioGroup<T> extends StatefulWidget {
  final List<RadioItem<T>> items;
  T value;
  final ValueChanged<T>? onSelected;
  final double itemSpacing;

  RadioGroup({
    super.key,
    required this.items,
    required this.value,
    this.onSelected,
    this.itemSpacing = 8.0,
  });

  @override
  _RadioGroupState<T> createState() => _RadioGroupState<T>();

  static _RadioGroupState<T> of<T>(BuildContext context) =>
      context.findAncestorStateOfType<_RadioGroupState<T>>()!;
}

class _RadioGroupState<T> extends State<RadioGroup<T>> {
  late T _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  void select(T value) {
    setState(() {
      _selectedValue = value;
    });
    if (widget.onSelected != null) {
      widget.onSelected!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: widget.itemSpacing,
      children: widget.items.map((item) {
        return RadioItem<T>(
          label: item.label,
          icon: item.icon,
          unselectedColor: item.unselectedColor,
          selectedColor: item.selectedColor,
          unselectedHeight: item.unselectedHeight,
          unselectedWidth: item.unselectedWidth,
          selectedHeight: item.selectedHeight,
          selectedWidth: item.selectedWidth,
          value: item.value,
          onChanged: item.onChanged,
        );
      }).toList(),
    );
  }

  static _RadioGroupState<T> of<T>(BuildContext context) {
    return context.findAncestorStateOfType<_RadioGroupState<T>>()!;
  }

  T get value => _selectedValue;
}
