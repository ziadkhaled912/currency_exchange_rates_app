import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
// import '../test/features/home_page/presentation/pages/home_page_test.dart' as home_page_test;
import 'features/currency_calculator/presentation/pages/currency_calculator_page_test.dart' as currency_calculator_page;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  // home_page_test.main();
  currency_calculator_page.main();
}
