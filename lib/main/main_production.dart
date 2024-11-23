import 'package:currency_exchange/flavor.dart';
import 'package:currency_exchange/bootstrap.dart';

void main() {
  AppFlavor.instance.flavor = Flavor.production;
  bootstrap();
}
