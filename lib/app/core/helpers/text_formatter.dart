import 'package:intl/intl.dart';

class TextFormatter {
  TextFormatter._();
  static final _formatRealPattern =
      NumberFormat.simpleCurrency(locale: 'pt_BR');
  static String formatReal(double number) => _formatRealPattern.format(number);
}
