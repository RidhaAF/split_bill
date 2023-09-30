import 'package:intl/intl.dart';
import 'package:split_bill/pages/bill/widgets/bill_item.dart';

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

int calculateSubtotal(List<BillItem> billItems) {
  int subtotal = 0;
  for (var item in billItems) {
    subtotal += item.calculateTotalPrice();
  }

  return subtotal;
}

int calculateTotal(
  List<BillItem> billItems, {
  required String service,
  required String tax,
}) {
  int subtotal = calculateSubtotal(billItems);
  int itemService = int.tryParse(service) ?? 0;
  int itemTax = int.tryParse(tax) ?? 0;

  return subtotal + itemService + itemTax;
}
