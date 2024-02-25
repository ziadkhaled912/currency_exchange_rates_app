import 'package:currency_exchange/flavor.dart';
import 'package:currency_exchange/main.dart';

void main() {
  AppFlavor.instance.flavor = Flavor.mock;
  bootstrap();
}
