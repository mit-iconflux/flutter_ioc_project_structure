import 'package:flutter/services.dart';

class TextCapitalizationFormatter extends TextInputFormatter {
  TextCapitalizationFormatter(this.capitalization);

  final TextCapitalization capitalization;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = '';

    switch (capitalization) {
      case TextCapitalization.words:
        text = capitalizeFirstOfEach(newValue.text);
        break;
      case TextCapitalization.sentences:
        final List<String> sentences = newValue.text.split('.');
        for (int i = 0; i < sentences.length; i++) {
          sentences[i] = inCaps(sentences[i]);
        }
        text = sentences.join('.');
        break;
      case TextCapitalization.characters:
        text = allInCaps(newValue.text);
        break;
      case TextCapitalization.none:
        text = newValue.text;
        break;
    }

    return TextEditingValue(
      text: text,
      selection: newValue.selection,
    );
  }

  /// 'Hello world'
  static String inCaps(String text) {
    if (text.isEmpty) {
      return text;
    }
    String result = '';
    for (int i = 0; i < text.length; i++) {
      if (text[i] != ' ') {
        result += '${text[i].toUpperCase()}${text.substring(i + 1)}';
        break;
      } else {
        result += text[i];
      }
    }
    return result;
  }

  /// 'HELLO WORLD'
  static String allInCaps(String text) => text.toUpperCase();

  /// 'Hello World'
  static String capitalizeFirstOfEach(String text) => text
      .replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((String str) => inCaps(str))
      .join(' ');
}
