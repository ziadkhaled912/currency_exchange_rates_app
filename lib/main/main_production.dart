import 'package:currency_exchange/flavor.dart';
import 'package:currency_exchange/startup.dart';

void main() {
  AppFlavor.instance.flavor = Flavor.production;
  bootstrap();
}
