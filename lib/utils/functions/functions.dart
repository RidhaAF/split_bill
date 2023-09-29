import 'package:intl/intl.dart';

String dateTimeFormatter(DateTime dateTime) {
  return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
}
