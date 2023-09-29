import 'package:intl/intl.dart';

String dateTimeFormatter(DateTime dateTime) {
  return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
}

String moneyFormatter(String money) {
  final int moneyInt = int.tryParse(money) ?? 0;
  final NumberFormat formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  return formatter.format(moneyInt);
}

String countItemTotalPrice({required String qty, required String price}) {
  final int itemQty = int.tryParse(qty) ?? 1;
  final int itemPrice = int.tryParse(price) ?? 0;

  return (itemQty * itemPrice).toString();
}
