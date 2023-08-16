import 'package:flutter/material.dart';

///Переписанный класс DropDown
class DropDownCustom<T> extends StatefulWidget {
  /// Элементы
  final List<T> items;

  /// Начальное значение
  final T? initialValue;

  /// Подсказки
  final Widget? hint;

  /// Функция изменения
  final Function(T?)? onChanged;

  /// иконка
  final Widget? icon;

  /// Стиль текста
  final TextStyle? textStyle;

  /// You can choose between show an underline at bottom or not
  final bool showUnderline;

  ///
  const DropDownCustom({
    required this.items,
    this.initialValue,
    this.hint,
    this.onChanged,
    this.textStyle,
    this.icon,
    this.showUnderline = false,
    Key? key,
  })  : assert(items is! Widget),
        super(key: key);

  @override
  _DropDownCustomState<T> createState() => _DropDownCustomState<T>();
}

class _DropDownCustomState<T> extends State<DropDownCustom<T>> {
  T? selectedValue;

  @override
  void initState() {
    selectedValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget dropdown;

    dropdown = DropdownButton<T>(
      onChanged: (value) {
        setState(() => selectedValue = value);
        widget.onChanged?.call(value);
      },
      items: widget.items.map<DropdownMenuItem<T>>(buildDropDownItem).toList(),
      hint: widget.hint,
      icon: widget.icon ??
          const Icon(
            Icons.expand_more,
          ),
      value: selectedValue,
    );

    return widget.showUnderline
        ? dropdown
        : DropdownButtonHideUnderline(child: dropdown);
  }

  DropdownMenuItem<T> buildDropDownItem(T item) => DropdownMenuItem<T>(
        child: Text(item.toString(), style: widget.textStyle),
        value: item,
      );
}
