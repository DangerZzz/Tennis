import 'package:flutter/cupertino.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

/// Описан для компановки кода в WM
class CodeTextFieldTool {
  /// Контроллер
  TextEditingController textEditingController = TextEditingController();

  /// [MaskTextInputFormatter]
  MaskTextInputFormatter maskTextInputFormatter = MaskTextInputFormatter(
    mask: '####',
    filter: {'#': RegExp(r'[0-9]')},
  );
}
