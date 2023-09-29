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

String countSubtotal({required List items}) {
  int subtotal = 0;

  for (var item in items) {
    final int itemTotalPrice = int.tryParse(item['item_total_price']) ?? 0;
    subtotal += itemTotalPrice;
  }

  return subtotal.toString();
}

String countTotalPrice({
  required String subtotal,
  required String service,
  required String tax,
}) {
  int totalPrice = 0;

  final int billSubtotal = int.tryParse(subtotal) ?? 0;
  final int billService = int.tryParse(service) ?? 0;
  final int billTax = int.tryParse(tax) ?? 0;

  totalPrice = billSubtotal + billService + billTax;

  return totalPrice.toString();
}
