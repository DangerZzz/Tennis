import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/features/authorization/tools/code_text_field_tool.dart';
import 'package:soft_weather_tennis/features/authorization/widgets/code_block.dart';

/// Виджет, реализующий отрисовку полей для кода
class CodeField extends StatefulWidget {
  /// [CodeTextFieldTool] для внутренего [TextField]
  final CodeTextFieldTool codeTextFieldTool;

  /// call back на изменение состояния кода
  final Function(String) handler;

  /// Флаг доступности редактирования кода =
  final bool enabled;

  /// Коструктор [CodeField]
  const CodeField({
    required this.codeTextFieldTool,
    required this.handler,
    required this.enabled,
    Key? key,
  }) : super(key: key);

  @override
  State<CodeField> createState() => _CodeFieldState();
}

class _CodeFieldState extends State<CodeField> {
  final int codeLen = 4;
  final List<String> code = [];

  bool _active = false;

  _CodeFieldState() {
    code.addAll(List.generate(codeLen, (index) => ''));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < codeLen; i++) ...[
              CodeBlock(
                number: code[i],
                focus: _active && i == code.indexOf(''),
              ),
              if (codeLen - 1 != i)
                const SizedBox(
                  width: 26,
                ),
            ],
          ],
        ),
        Center(
          child: SizedBox(
            height: 46,
            width: 228,
            child: TextField(
              controller: widget.codeTextFieldTool.textEditingController,
              enabled: widget.enabled,
              showCursor: false,
              style: const TextStyle(color: Colors.transparent),
              onTap: () {
                setState(() {
                  _active = true;
                });
              },
              onEditingComplete: () {
                setState(() {
                  _active = false;
                });
              },
              inputFormatters: [
                widget.codeTextFieldTool.maskTextInputFormatter,
              ],
              onChanged: (line) {
                setState(() {
                  for (var i = 0; i < code.length; i++) {
                    if (widget.codeTextFieldTool.textEditingController.text
                            .length >
                        i) {
                      code[i] = widget
                          .codeTextFieldTool.textEditingController.text[i];
                    } else {
                      code[i] = '';
                    }
                  }
                });
                if (widget
                        .codeTextFieldTool.textEditingController.text.length ==
                    code.length) {
                  widget.handler(line);
                }
              },
              keyboardType: TextInputType.number,
              cursorColor: Colors.transparent,
              // toolbarOptions: const ToolbarOptions(),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
